#!/usr/bin/perl -w

sub mm{

}
# fill_form.cgi

# bundle up form output and mail it to the specified address

# This program is copyright 1999 by John Callender.

# This program is free and open software. You may use, copy, modify,
# distribute and sell this program (and any modified variants) in any way
# you wish, provided you do not restrict others from doing the same.

# configuration:

$sendmail = '/usr/sbin/sendmail'; # where is sendmail?
$recipient = 'forms@lies.com'; # who gets the form data?
$sender = 'Anonymous User <forms@lies.com>'; # default sender?
$site_name = 'TLD'; # name of site to return to afterwards
$site_url = '.'; # URL of site to return to afterwards
print "Content-type: text/html\n\n";

# script proper begins...

use CGI;
$query = new CGI;

# bundle up form submissions into a mail_body

$mail_body = '';

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
        system("perl mm.pl tempmain tempother 2 temptest > tempresult");
        open(T, "tempresult");
        $tf=<T>;
        print "RESULT - $tf\n";
        #print "Detected: English\n";
 
# set an appropriate From: address

if ($email = $query->param('07_email')) {
    # the user supplied an email address
    if ($name = $query->param('01_name')) {
        # the user supplied a name
        $name =~ s/"//g; # lose any double-quotes in name
        $sender = "\"$name\" <$email>";
    } else {
        # user did not supply a name
        $sender = "$email";
    }
}

# send the email message

#open(MAIL, "|$sendmail -oi -t") or die "Can't open pipe to $sendmail: $!\n";
#print MAIL "To: $recipient\n";
#print MAIL "From: $sender\n"; 
#print MAIL "Subject: Sample Web Form Submission\n\n";
#print MAIL "$mail_body";
#close(MAIL) or die "Can't close pipe to $sendmail: $!\n";

# now show the thank-you screen

print <<"EOF";
<HTML>
<HEAD>
</HEAD>

<BODY>

<P>Return to 
<A HREF="$site_url">$site_name</A>.</P>

</BODY>
</HTML>
EOF

