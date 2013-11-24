#!/usr/bin/perl
use strict;

# Removes posts of any type except 1 and 2
# Temporoary hack file, shouldn't need again

if (@ARGV != 1){
    print "Usage: $0 posts-pretmp.csv\n";
    exit;
}
my $file = shift;

open (IN, "<", $file) or die();

while (<IN>){
    my @c = split /\|/;
    my $type   = $c[1];
    if ($type == "1" || $type == "2"){
        print;
    } else {
        print STDERR "skipped $type\n";
    } 
}




