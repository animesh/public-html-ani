#!/usr/bin/perl -w
print "Content-type: text/html\n\n";
use CGI;
$query = new CGI;
foreach $field (sort ($query->param)) {
    foreach $value ($query->param($field)) {
	print "<p>\n";
        print "$field - $value\n";
        $mail_body .= "$field: $value\n";
	if($field eq "Text"){open(FTT,">temptest");$stext=$value;print FTT "$value";}
	if($field eq "MainLanguage"){$ml=$value;system("elinks -dump $ml > tempmain");}
	if($field eq "OtherLanguage"){$ol=$value;system("elinks -dump $ol > tempother");}
	if($field eq "model_number"){$model=$value}
    }
}

	print "<p>\n";
        system("perl MM.pl tempmain tempother 2 temptest > tempresult");
        open(T, "tempresult");
        $tf=<T>;
        print "RESULT - $tf\n";
print <<"EOF";
<HTML>
<HEAD>
</HEAD>
<BODY>
<P>Return to 
<A HREF=".">TLD</A>.</P>
</BODY>
</HTML>
EOF

