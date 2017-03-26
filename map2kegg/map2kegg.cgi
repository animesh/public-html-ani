#!/usr/bin/perl -w
print "Content-type: text/html\n\n";
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI qw(:standard);
print "<a href=\"http://map2kegg.massturbinator.com/tmp/output.png\">Mapped Pathway</a>";
print header();
warningsToBrowser(1);
$query = new CGI;
use Statistics::R;
my $R = Statistics::R->new();
$R->run(q`y <- setwd("/tmp")`);

foreach my $field (sort ($query->param)) {
    foreach my $value ($query->param($field)) {
	print "<p>\n";
	if($field eq "KEGG"){
		my $value=lc($value);
		$R->set('pvf', $value);
        	print "$field - $value\n";
        }
	if($field eq "GV"){
		my $value=uc($value);
		$R->set('hda', $value);
	        print "$field - $value\n";
	}
    }
}

	print "<p>\n";
        system("rm /tmp/*map2kegg.*png");
$R->run(q`y <-	 write.table(hda,"/tmp/inppvr.txt")`);
my $sedout=system("sed  1d  /tmp/inppvr.txt | sed 's/\"1\"//g' |  sed 's/\"//g'  | sed 's/\s+//g' | sed 's/^ //g'> /tmp/inppvrsed.txt");
print $sedout;
$R->run(q`hda <- read.table("/tmp/inppvrsed.txt",row.names=1, header=T)`);
my $summar=$R->run(q`summary(hda)`);
print $summar;
$R->run(q`y <- library(pathview)`);
$R->run(q`y <- pathview(hda,pathway.id=pvf,gene.idtype="symbol",low = list(gene = "blue"), mid = list(gene = "white"), high = list(gene = "orange"), both.dirs=list(gene=T),na.col="transparent", out="map2kegg")`);
        system("cp /tmp/*map2kegg*png /tmp/output.png");

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

