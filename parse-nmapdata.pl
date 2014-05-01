#!/usr/bin/env perl
#
# Parse nmap scan tool : parse-nmapdata.pl
# Awfully written by: Mike Harris <MikeDawg@gmail.com>
# Version: .003
#
# Changes:  .003 - Cleaned up code a little more, changed shebang
#					  .002 - Got rid of that trailing comma
#
# Please make sure you have installed Nmap::Parser in perl before using this script.
# perl -MCPAN -e 'install Nmap::Parser'
#
use strict;
use warnings;

#
#
use Nmap::Parser;
my $np = new Nmap::Parser;

#
print "Enter filename of nmap xml (input):  ";
my $userFileName = <STDIN>;
chomp $userFileName;
exit 0 if ( $userFileName eq "" );
print "Enter output filename:  ";
my $userOutputFileName = <STDIN>;
chomp $userOutputFileName;
exit 0 if ( $userOutputFileName eq "" );

if ( -e $userOutputFileName ) {
    print
"Output file already exists. To append to this file, press y, to cancel press n:  ";
    my $fileTest = <STDIN>;
    chomp $fileTest;
    if ( $fileTest =~ /^[N]?$/i ) {
        exit 0;
    }
}

#
$np->callback( \&parseDataSub );

#
$np->parsefile($userFileName);

sub parseDataSub {
    my $host = shift;
    my @portLists;
    open( my $MYOUTFILE, ">>", "$userOutputFileName" )
      || die "Can't open $userOutputFileName";
    print $MYOUTFILE "-p";
    for my $port ( $host->tcp_ports('open') ) {
        push @portLists, $port, ",";
    }
    chop $portLists[-1];
    print $MYOUTFILE @portLists;
    print $MYOUTFILE " ";
    print $MYOUTFILE $host->addr, "\n";
    close($MYOUTFILE);
}
