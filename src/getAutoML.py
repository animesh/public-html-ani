#https://cloud.google.com/natural-language/automl/docs/samples/automl-language-sentiment-analysis-create-model
#pip3 install google-cloud-automl
from google.cloud import automl

project_id = "gita-256714"
display_name = "fuzzylife"
dataset_id = "a14lyf3"

client = automl.AutoMlClient()

# A resource that represents Google Cloud Platform location.
project_location = f"projects/{project_id}/locations/us-central1"
# Leave model unset to use the default base model provided by Google
metadata = automl.TextSentimentModelMetadata()
model = automl.Model(
    display_name=display_name,
    dataset_id=dataset_id,
    text_sentiment_model_metadata=metadata,
)

# Create a model with the model metadata in the region.
response = client.create_model(parent=project_location, model=model)

print("Training operation name: {}".format(response.operation.name))
print("Training started...")
