#!/usr/bin/perl
use strict;

# Removes words that occur less than 10 times from the posts-pre.csv file
# Temporoary hack file, shouldn't need again

if (@ARGV != 2){
    print "Usage: $0 posts_tags.csv tags.csv\n";
    exit;
}
my $file = shift;
my $file2 = shift;

my %count;

open (IN, "<", $file) or die();

# Do tag counts

my $i = 0;
while (<IN>){
    chomp;
    my @c = split /\|/;
    my $tag   = $c[1];
    if (!exists($count{$tag})){
        $count{$tag} = 1;
    }

    # Progress printer
    $i++;
    if ($i % 100000 == 0){
        print STDERR "count $i\n";
    }
}
close IN;

# Now, output the stuff


open (IN, "<", $file2) or die();
$i = 0;
while (<IN>){
    my @c = split /\|/;
    my $tag   = $c[0];
    if (exists($count{$tag})){
        print;
    }

    $i++;
    if ($i % 100000 == 0){
        print STDERR "print $i\n";
    }
}
close IN;


