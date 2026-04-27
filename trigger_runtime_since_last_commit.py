import json
import re
import subprocess
from datetime import datetime, timezone
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd
import requests
import seaborn as sns

sns.set_theme(style='whitegrid')

repo_root = Path('.')
workflow_dir = repo_root / '.github' / 'workflows'
workflow_files = sorted(workflow_dir.glob('*.yml'))
if not workflow_files:
    raise FileNotFoundError('No workflow files found in .github/workflows')

remote_url = subprocess.check_output(['git', 'remote', 'get-url', 'origin'], text=True).strip().rstrip('/')
remote_match = re.search(r'github\.com[:/](?P<owner>[^/]+)/(?P<repo>[^/]+?)(?:\.git)?$', remote_url)
if not remote_match:
    raise RuntimeError(f'Unable to parse GitHub repo from remote URL: {remote_url}')
owner = remote_match.group('owner')
repo = remote_match.group('repo')

last_workflow_commit = subprocess.check_output(
    ['git', 'log', '-1', '--date=iso-strict', '--pretty=format:%H|%ad|%s', '--'] + [str(wf).replace('\\', '/') for wf in workflow_files],
    text=True,
    errors='replace',
).strip()
commit_hash, commit_date_str, commit_subject = last_workflow_commit.split('|', 2)
commit_date = datetime.fromisoformat(commit_date_str)

current_schedules = []
for wf in workflow_files:
    with wf.open('r', encoding='utf-8') as f:
        for line in f:
            if 'cron:' in line:
                cron_value = line.split('cron:')[1].strip().strip('"\'')
                current_schedules.append({'file': wf.name, 'cron': cron_value})
                break

api_url = f'https://api.github.com/repos/{owner}/{repo}/actions/runs'
runs = []
page = 1
while page <= 5:
    params = {'per_page': 100, 'page': page}
    resp = requests.get(api_url, params=params, headers={'Accept': 'application/vnd.github+json'})
    if resp.status_code != 200:
        raise RuntimeError(f'GitHub API request failed: {resp.status_code} {resp.text}')
    data = resp.json()
    runs.extend(data.get('workflow_runs', []))
    if 'next' not in resp.links:
        break
    page += 1

scheduled_runs = []
for run in runs:
    if run.get('event') != 'schedule':
        continue
    run_started_at = run.get('run_started_at') or run.get('created_at')
    if not run_started_at:
        continue
    started_at = datetime.fromisoformat(run_started_at.replace('Z', '+00:00'))
    if started_at < commit_date:
        continue
    completed_at = run.get('updated_at')
    if completed_at:
        completed_at = datetime.fromisoformat(completed_at.replace('Z', '+00:00'))
    else:
        completed_at = None
    duration = None
    if completed_at and started_at:
        duration = (completed_at - started_at).total_seconds() / 60.0
    scheduled_runs.append({
        'id': run.get('id'),
        'name': run.get('name') or run.get('workflow_name'),
        'workflow_id': run.get('workflow_id'),
        'head_branch': run.get('head_branch'),
        'created_at': datetime.fromisoformat(run['created_at'].replace('Z', '+00:00')), 
        'run_started_at': started_at,
        'completed_at': completed_at,
        'duration_min': duration,
        'status': run.get('status'),
        'conclusion': run.get('conclusion'),
        'html_url': run.get('html_url'),
    })

if not scheduled_runs:
    print('No scheduled GitHub Actions runs found since the last workflow commit.')
    raise SystemExit(0)

scheduled_df = pd.DataFrame(scheduled_runs)
scheduled_df['start_hour'] = scheduled_df['run_started_at'].dt.hour + scheduled_df['run_started_at'].dt.minute / 60.0
scheduled_df['run_date'] = scheduled_df['run_started_at'].dt.date

plot_path = repo_root / 'trigger_runtime_since_last_commit.png'
plt.figure(figsize=(10, 5))
for name, group in scheduled_df.groupby('name'):
    plt.plot(group['run_date'], group['start_hour'], marker='o', label=name)
plt.title('Actual Scheduled Trigger Time Since Last Workflow Commit')
plt.xlabel('Run date')
plt.ylabel('Start time (UTC hour)')
plt.yticks(range(0, 24))
plt.legend(title='Workflow')
plt.tight_layout()
plt.savefig(plot_path, dpi=200)
plt.close()

plot_duration_path = repo_root / 'trigger_duration_since_last_commit.png'
plt.figure(figsize=(10, 5))
for name, group in scheduled_df.groupby('name'):
    plt.plot(group['run_date'], group['duration_min'], marker='o', label=name)
plt.title('Actual Workflow Runtime Since Last Workflow Commit')
plt.xlabel('Run date')
plt.ylabel('Duration (minutes)')
plt.legend(title='Workflow')
plt.tight_layout()
plt.savefig(plot_duration_path, dpi=200)
plt.close()

print('Last workflow commit:')
print(f'  {commit_hash} on {commit_date.isoformat()}')
print(f'  {commit_subject}')
print('\nCurrent configured cron schedules:')
for s in current_schedules:
    print(f"  {s['file']}: {s['cron']}")

print('\nScheduled runs since last workflow commit:')
print(scheduled_df[['id', 'name', 'run_date', 'run_started_at', 'duration_min', 'status', 'conclusion', 'html_url']].to_string(index=False))

print('\nSummary statistics:')
print('  Count:', len(scheduled_df))
print('  Start hour mean:', scheduled_df['start_hour'].mean())
print('  Duration mean (min):', scheduled_df['duration_min'].mean())
print('  Duration median (min):', scheduled_df['duration_min'].median())
print('  Duration min (min):', scheduled_df['duration_min'].min())
print('  Duration max (min):', scheduled_df['duration_min'].max())
print('\nPlots saved:')
print('  ', plot_path)
print('  ', plot_duration_path)
