#!/usr/bin/perl
#
# Stephen W. Thomas
# sthomas@cs.queensu.ca
# http://research.cs.queensu.ca/~sthomas/
# Software Analysis and Intelligence Lab (SAIL)
# School of Computing, Queen's University, Canada
#
################################################################################

use File::Basename;
use strict;
use warnings;
local $| = 1;


# Check argumets
if ($#ARGV != 0 ){ 
   print "$0: Error: Incorrect usage.\n";
   print "$0 outputstate.txt\n";
   print "Exiting.\n";
   exit 1;  
}

my $stateName=shift;
my @words;

print "$0: Log: Word Counts.\n";
open(INFILE,   "<$stateName")     or die ("$0: Error: Can't open input file $stateName");
    while (<INFILE>){
        if (/^#/){ }   # Skip comments
        else{
            my @cols = split;
            my $idx  = $cols[3];
            my $word = $cols[4];
            $words[$idx] = $word;
        }
    }
close(INFILE);

print "$0: Log: Printing.\n";
open(OUT, ">vocab.dat")   or die ("$0: Error: Can't open output file.");
for (my $i = 0; $i < scalar(@words); ++$i){
    print OUT $words[$i]."\n";
}

