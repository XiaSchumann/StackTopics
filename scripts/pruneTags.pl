#!/usr/bin/perl
use strict;

# Removes words that occur less than 10 times from the posts-pre.csv file
# Temporoary hack file, shouldn't need again

if (@ARGV != 1){
    print "Usage: $0 posts_tags.csv\n";
    exit;
}
my $file = shift;

my %count;

open (IN, "<", $file) or die();

# Do tag counts

my $i = 0;
while (<IN>){
    chomp;
    my @c = split /\|/;
    my $tag   = $c[1];
    if (exists($count{$tag})){
        $count{$tag} = $count{$tag} + 1;
    } else {
        $count{$tag} = 1;
    }

    # Progress printer
    $i++;
    if ($i % 100000 == 0){
        print STDERR "count $i\n";
    }
}
close IN;

#my @keys = sort { $count{$a} <=> $count{$b} } keys(%count);
#foreach my $w (@keys){
    #print "$count{$w}, $w\n";
##}
#exit;


# Now, output the stuff


open (IN, "<", $file) or die();
$i = 0;
while (<IN>){
    chomp;
    my @c = split /\|/;
    my $tag   = $c[1];
    if ($count{$tag} > 1000){
        print "$c[0]|$tag\n";
    }

    $i++;
    if ($i % 100000 == 0){
        print STDERR "print $i\n";
    }
}
close IN;


