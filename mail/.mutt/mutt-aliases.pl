#!/usr/bin/env perl
#use warnings;
use strict;
use Data::Dumper;
use Net::LDAP;
my $aliases = "~/.mutt/aliases";
my $group = "it-staff";
my @members;
my $ldap = Net::LDAP->new("ldap.su.se");
my $result = $ldap->search(filter => "(cn=$group)", attrs => ['uniqueMember']);

@members = $result->entry->get("uniqueMember");
$result->code && die $result->error;

open(ALIASES, ">".glob($aliases)) or die $!;
for (@members) {
 s/uid=(.*?),.*/$1/;
 my $uid = $_;
 $result = $ldap->search(filter => "(uid=$uid)", attrs => ['mailLocalAddress', 'sn', 'givenName']);
 my $givenname = $result->entry->get_value("givenName");
 my $sn = $result->entry->get_value("sn");
 my $name = "$givenname $sn";
 my @mails;
 for ($result->entry->get("mailLocalAddress")) {
   push @mails, $_ if /$uid|$givenname|$sn/i and /su.se/;
 }
 # Use shorter mailaddresses rather than long ones
 @mails = sort {length $a <=> length $b} @mails;
 # Also, don't write to the alias file unless they have a mail
 print ALIASES "alias $uid $name <".$mails[0].">\n" unless $#mails < 0;
}
close ALIASES;

$ldap->unbind;
