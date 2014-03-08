#!/usr/bin/perl
print "Content-type: text/html\n\n";
use CGI;
my $query = new CGI;
my $pep=$query->param("Peptide");
chomp $pep;
print "<p> Peptide: $pep <p>";
system("./pepcleave.pl ../merop.form.list $pep > ../tempresult");
open(T, "../tempresult");
my $tf=<T>;
print "RESULT - $tf <p>";
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

