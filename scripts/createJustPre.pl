#!/usr/bin/perl
use strict;

if (@ARGV != 1){
    print "Usage: $0 csv \n";
    exit;
}
my $file = shift;

open (IN, "<", $file) or die();

while (<IN>){
    chomp;
    my @c = split /\|/;
    my $id   = $c[0];
    my $text = $c[4];
    print "$id 0 $text\n";
}




