#!/usr/bin/perl
use strict;

# Removes words that occur less than 10 times from the posts-pre.csv file
# Temporoary hack file, shouldn't need again

if (@ARGV != 1){
    print "Usage: $0 posts-tmp.csv\n";
    exit;
}
my $file = shift;

my %count;

open (IN, "<", $file) or die();

# Do word counts

my $i = 0;
while (<IN>){
    chomp;
    my @c = split /\|/;
    my $pre   = $c[4];
    my @words = split " ", $pre;
    foreach my $word (@words){
        if (exists($count{$word})){
            $count{$word} = $count{$word} + 1;
        } else {
            $count{$word} = 1;
        }
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
#}
#exit;


# Now, output the stuff


open (IN, "<", $file) or die();

# Do word counts

$i = 0;
while (<IN>){
    chomp;
    my @c = split /\|/;
    my $pre   = $c[4];
    my @words = split " ", $pre;
    print "$c[0]|$c[1]|$c[2]|$c[3]|";
    foreach my $word (@words){
        if ($count{$word} > 1000){
            print $word.' ';
        }
    }
    print "|\n";

    $i++;
    if ($i % 100000 == 0){
        print STDERR "print $i\n";
    }
}
close IN;


