#!/usr/bin/perl

use File::Basename;
use strict;
use warnings;

# Check argumets
if ($#ARGV != 0 ){ 
   print "$0: Error: Incorrect usage.\n";
   print "$0 allfiles.txt\n";
   exit 1;  
}

my $inName=shift;

open(INFILE,   "<$inName")     or die ("$0: Error: Can't open input file $inName");

while (<INFILE>){
    if (/^#/){ }   # Skip comments
    else{
        chomp;
        my @cols        = split;
        my $curFileName = $cols[1]; 
        my($postID, $dir)   = fileparse($curFileName);

        my $N = (scalar(@cols)-2)/2;   # number of cols

        my $min = 1/$N;

        # The lines have topic amount topic amount ... 
        for (my $i=2;$i<=$N+2;$i+=2){
            my $topicID = $cols[$i];
            my $weight  = scalar($cols[$i+1]); 
            if ($weight > $min){
                printf "%s|%s|%.3f\n", $postID,$topicID,$weight;
            }
        }   
    }   
}

