#!/usr/bin/perl -w
print "Content-type: text/html\n\n";
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI qw(:standard);
my $vtime=time;
print "<a href=\"http://map2kegg.massturbinator.com/tmp/$vtime.output.png\">Mapped Pathway</a><p>";
print header();
warningsToBrowser(1);
$query = new CGI;
use Statistics::R;
my $R = Statistics::R->new();
$R->run(q`y <- setwd("/tmp")`);
my $time=time;
$R->set('sfx', $vtime);
my $code;
my $species;
foreach my $field ( ($query->param)) {
    foreach my $value ($query->param($field)) {
	print "<p>\n";
        if($field eq "CODE"){
                $code=sprintf("%05d", $value);
                print "$field - $code\n";
        }
        if($field eq "SPECIES"){
               $species=lc($value);
              $R->set('pspecies', $species);
             print "$field - $species\n";
        }
	if($field eq "GV"){
		my $value=uc($value);
		$R->set('hda', $value);
	        print "$field - $value\n";
	}
    }
}
$R->set('pcode', "$species$code");
my $keggorig="http://www.genome.jp/kegg-bin/show_pathway?$species$code";
print "<p><a href=$keggorig>Original Pathway</a><p>";
system("rm -rf /tmp/$vtime.output.png");
$R->run(q`y <-	 write.table(hda,"/tmp/inppvr.txt")`);
my $sedout=system("sed  1d  /tmp/inppvr.txt | sed 's/\"1\"//g' |  sed 's/\"//g'  | sed 's/\s+//g' | sed 's/^ //g'> /tmp/inppvrsed.txt");
print $sedout;
$R->run(q`hda <- read.table("/tmp/inppvrsed.txt",row.names=1, header=T)`);
my $summar=$R->run(q`summary(hda)`);
my $sump=$R->run(q`pcode`);
print $summar;
print $sump;
$R->run(q`y <- library(pathview)`);
my $summarp=$R->run(q`pathview(hda,pathway.id=pcode, species=pspecies,gene.idtype="UNIPROT",low = list(gene = "blue"), mid = list(gene = "white"), high = list(gene = "red"), both.dirs=list(gene=T),na.col="transparent", out=sfx)`);
print $summarp;
my $outres=system("cp /tmp/*$vtime*png /tmp/$vtime.output.png");
print $outres;

print <<"EOF";
<HTML>
<HEAD>
</HEAD>
<BODY>
<P>Return to 
<A HREF=".">Form</A>.</P>
</BODY>
</HTML>
EOF

