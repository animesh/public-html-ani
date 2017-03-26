#!/usr/bin/perl
$file3=shift @ARGV;
$colo=4;
open(FT,$file3);
while($seq=<FT>){
		chomp $seq;
		$len=length($seq);
		for($cot=0;$cot<=($len-$colo);$cot++)
			{$subs=substr($seq,$cot,$colo);
			if(($mash2{$subs} ne "") and ($mash1{$subs} ne ""))
				{$p=$mash1{$subs}/$mash2{$subs};1/1;
				$prob+=log($p);}
			elsif(($mash2{$subs} eq "") and ($mash1{$subs} eq ""))
				{$p=$cash2/$cash1;1/1;
				$prob+=log($p);}
			elsif($mash2{$subs} eq "")
				{$p=$mash1{$subs}/(1/$cash2);#print "$p\n";
				$prob+=log($p);}
			elsif($mash1{$subs} eq "")
				{$p=(1/$cash1)/$mash2{$subs};
				$prob+=log($p);}
			}
}
if($prob gt 0){
print "coding\t$seqname\t$prob\n";
print FC1">$seqname\tP-$prob\n$seq\n";
}
elsif($prob eq 0){
print "fifty-fifty !\t$seqname\t$prob\n";
print FC3">$seqname\tP-$prob\n$seq\n";
}
else{
print "non-coding\t$seqname\t$prob\n";
print FC2">$seqname\tP-$prob\n$seq\n";
}
