#!/usr/bin/perl
use strict;

if (@ARGV != 2){
    print "Usage: $0 posts-pretmp.csv posts_tagstmp.csv \n";
    exit;
}
my $postfile = shift;
my $tagfile = shift;

open (IN, "<", $postfile) or die();

my %dates;

# First, read in dates for all posts
my $i;
while (<IN>){
    chomp;
    my @c = split /\|/;
    my $id   = $c[0];
    my $date = $c[2];
    substr($date,8,2) = "01";
    $dates{$id} = $date;
    $i++;
    if (($i % 100000) == 0){
        print STDERR "$i\n";
    }
}

close(IN);


open (IN, "<", $tagfile) or die();

while (<IN>){
    chomp;
    my @c = split /\|/;
    my $id   = $c[0];
    print "$_|$dates{$id}\n";
}



