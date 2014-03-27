#!/usr/bin/perl
use strict;
use Statistics::Regression;
use Statistics::Distributions;
print "Content-type: text/html\n\n";
use CGI;
my $query = new CGI;
my $val=$query->param("Values");
#$val=" 1 1.3 2 2.9 3 4.2 4 5.4 ";
#print "<p> Values: $val <p>";
$val=~s/^\s+//g;
$val=~s/\s+$//g;
my @valt=split(/\s+/,$val);
my $reg = Statistics::Regression->new( "check regression", [ "intercept", "slope" ] );
open(F,">../../regress/temp");
for(my $c=0;$c<=$#valt;$c=$c+2){
print F"$valt[$c]\t$valt[$c+1]\n";
  # Create regression object
if($valt[$c] ne "" and $valt[$c+1] ne ""){
  # Add data points
  $reg->include( $valt[$c+1] , [ 1 , $valt[$c]] );
}
}
  my @theta  = $reg->theta();
  my @se     = $reg->standarderrors();
  my $rsq    = $reg->rsq();
  my $adjrsq = $reg->adjrsq();
  my $ybar   = $reg->ybar();  ## the average of the y vector
  my $sst    = $reg->sst();  ## the sum-squares-total
  my $sigmasq= $reg->sigmasq();  ## the variance of the residual
  my $k      = $reg->k();   ## the number of variables
  my $n      = $reg->n();   ## the number of observations
my $pval= Statistics::Distributions::tprob($k,$theta[1]/$se[1]);
print "<p>$theta[1] [p-val: $pval]<p>";
system("perl chkgnufun.pl $theta[1] $theta[0]");
print("<img src=../../regress/temp.png>");
print "plot<p>";
$reg->print();
print "<p> Intercept - $theta[0], Slope - $theta[1], R^2 - $rsq, N - $n <p> " ;
print "<p> data-@valt <p>";
print <<"EOF";
<HTML>
<HEAD>
</HEAD>
<BODY>
<P>
<A HREF="../../regress">Return</A>.</P>
</BODY>
</HTML>
EOF

