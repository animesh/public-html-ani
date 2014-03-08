#!/usr/bin/perl
use strict;
print "Content-type: text/html\n\n";
use CGI;
my $query = new CGI;
my $pep=$query->param("Peptide");
chomp $pep;
print "<p> Peptide: $pep <p>";
#system("./pepcleave.pl ../merop.form.list $pep > ../tempresult");
#open(T, "../tempresult");
#my $tf=<T>;
#print "RESULT - $tf <p>";
sub clv {
my $file="../merop.form.list";
my $id=0;
my $pep=shift;chomp $pep;$pep=uc($pep);
#$pep="REWQ";
my $s=3;
my $e=10;
open(F,$file);
print "<p> MeropsID\tEnzyme\tPattern\tAmbiguity\tPosition <p>";
while(my $line=<F>){
	my @tmp=split(/\t/,$line);
	#my $mat = join('', @tmp[$s..$e]);
	my $mat;
        for(my $c=$s;$c<=$e;$c++){
                $tmp[$c]=uc($tmp[$c]);
                if($tmp[$c]=~/[A-Z]/ && length($tmp[$c])==1){
                        $mat.=$tmp[$c];
                }
                if($tmp[$c]=~/[A-Z]/ && length($tmp[$c])>1){
                        $mat.="[$tmp[$c]]";
                }
                else{$mat.="[A-Z]";}
        }
        my $num=$mat=~s/\[A\-Z\]/\[A\-Z\]/g;
        if($num!=($e-$s+1) and $mat=~/[A-Z]/ and $pep =~ /$mat/){
		my @temp;
		while($pep =~ /$mat/g){
			my $posi=pos($pep);
			$posi=($posi-($e-$s+1));
			push(@temp,$posi);
		}
		print " <p> $tmp[$id]\t$tmp[$id+1]\t$mat\t$num\t@temp <p>";
        }
}
}

clv($pep);

print <<"EOF";
<HTML>
<HEAD>
</HEAD>
<BODY>
<P>Return to
<A HREF="../">Back</A>.</P>
</BODY>
</HTML>
EOF

