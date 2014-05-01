#!/usr/bin/perl -w
#
# Parse nmap scan tool : parse-nmapdata.pl
# Awfully written by: Mike Harris <MikeDawg@gmail.com>
# Version: .002
# 
# Changes: .002 - Got rid of that trailing comma
#
# Please make sure you have installed Nmap::Parser in perl before using this script.
# perl -MCPAN -e 'install Nmap::Parser'
#
use strict;

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
$np->callback( \&booyah );

#
$np->parsefile($userFileName);

sub booyah {
   my $host = shift;
   my @portLists;
   open( MYOUTFILE, ">>$userOutputFileName" );
   print MYOUTFILE "-p";
   for my $port ( $host->tcp_ports('open') ) {
      push @portLists, $port, ",";
   }
   chop $portLists[-1];
   print MYOUTFILE @portLists;
   print MYOUTFILE " ";
   print MYOUTFILE $host->addr, "\n";
   close(MYOUTFILE);
}
