#!/usr/bin/perl -w
print "Content-type: text/html\n\n";
use CGI;
$query = new CGI;
foreach $field (sort ($query->param)) {
    foreach $value ($query->param($field)) {
	print "<p>\n";
        print "$field - $value\n";
        #$mail_body .= "$field: $value\n";
	if($field eq "TrainingData"){$ml=$value;system("wget $ml -O tempmain");}
	if($field eq "TestData"){$ol=$value;system("wget $ol -O tempother");}
	if($field eq "model_parameter"){$model=$value}
    }
}

	print "<p>\n";
system("perl ofs2svm.pl tempmain 2 2>2");
system("perl ofs2svm.pl tempother 2 2>2");
system("./svm_multiclass_learn -c 0.01 -t 1 -d $model tempmain.svm.out model > svmmodel");
        open(T, "svmmodel");
	while(<T>){if($_!~ m/^(C|N|I|F|V)/i){print $_,"<p>";}}
system("./svm_multiclass_classify tempother.svm.out  model predictions > svmprediction");
        open(T, "tempother.svm.out");
        while(<T>){push(@test,$_)}
        open(T, "predictions");
        while(<T>){push(@pred,$_)}
        print "<strong>RESULT:</strong><p>";
	$mis=0;
	for($c=0;$c<=$#test;$c++){
		$ex=$c+1;
		@tc=split(/\s+/,@test[$c]);
		@pc=split(/\s+/,@pred[$c]);
		if(@tc[0]!=@pc[0]){
			print "Test example $ex <strong>Misclassified</strong><p>";
			$mis++;
		}
                else{
                        print "Test example $ex Correctly classified<p>";
                }
		$perf=100*(1-$mis/$ex);
	} 
		print "$mis out of $ex are misclassified (Accuracy: $perf percent)<p>";
			
print <<"EOF";
<HTML>
<HEAD>
</HEAD>
<BODY>
<P>Return to 
<A HREF=".">SVM tutorial</A>.</P>
</BODY>
</HTML>
EOF

