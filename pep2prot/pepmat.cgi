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
    }
}

	print "<p>\n";
        system("perl pep2prot.pl hupo.fasta temptest > tempresult");
        open(T, "tempresult");
        $tf=<T>;
        print "Matches - $tf\n";
print <<"EOF";
<HTML>
<HEAD>
</HEAD>
<BODY>
<P>Return to 
<A HREF=".">Match form</A>.</P>
</BODY>
</HTML>
EOF

