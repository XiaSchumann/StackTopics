#!/usr/bin/perl
#
# Stephen W. Thomas
# sthomas@cs.queensu.ca
# http://research.cs.queensu.ca/~sthomas/
# Software Analysis and Intelligence Lab (SAIL)
# School of Computing, Queen's University, Canada
#
###############################################################################
use List::Util qw(reduce);
use strict;

# Check arguments
if ($#ARGV < 1){
   print "Usage: $0 wordweights.dat topics.dat \n";
   exit 1;
}

# Open output files
my $infile         = shift;
my $topics         = shift;

my $outfile        = "words.dat";
my $outfile2       = "words.txt";
my $outfile3       = "wordprobs.dat";

open(OUT,      ">$outfile")      or die ("$0: Error: Can't open output file $outfile");
open(OUT2,     ">$outfile2")      or die ("$0: Error: Can't open output file $outfile2");
open(OUT3,     ">$outfile3")      or die ("$0: Error: Can't open output file $outfile3");
open(INFILE,   "<$infile") or die ("$0: Error: Can't open input file $infile");
open(INFILE2,  "<$topics") or die ("$0: Error: Can't open input file $topics");

my %valhash;
my %wordIdx;  

my @array;
my @allwords;
my @allwords2;
my @sums;


#############################################
# First, reformat the wordweights into a matrix
my $curTopicIdx = -1; 
my $counter = 0; 
while (<INFILE>){
    chomp;
    my @c = split;

    if (scalar($c[0]) != $curTopicIdx){
        if ($curTopicIdx != -1){
            printWhatWeGot($curTopicIdx);
        }
        $counter=0;
        $curTopicIdx = scalar($c[0]);
    }
    $array[$counter] = $c[2];
    $allwords[$curTopicIdx][$counter] = $c[2];
    $wordIdx{$c[1]} = $counter;
    $counter++;
}
printWhatWeGot($curTopicIdx); # take care of last time
close(INFILE);

# Normalized
my $numTopics = scalar(@sums);
for (my $j=0; $j<$numTopics; $j++) {
       my $sum = $sums[$j];
       for (my $k=0; $k<=$#{$allwords[$j]}; $k++) {
            my $val = $allwords[$j][$k]/$sum;
            $allwords2[$j][$k] = $val;
       }
}


#############################################
# Now, strip first two columns from topics file
my $topicid = 0;
while (<INFILE2>){
    chomp;
    my @c = split;
    for (my $i=2;$i<scalar(@c);++$i){
        print OUT2 "$c[$i] ";

        my $idx = $wordIdx{$c[$i]};
        my $val = $allwords2[$topicid][$idx];
        printf OUT3 "%.4f ", $val;
    }
    print OUT2 "\n";
    print OUT3 "\n";

    $topicid++;

}
close(INFILE2);



#############################################
# Prints a topic, once it's been fully read in
#############################################
sub printWhatWeGot(){
  my $topicid = shift;
  my $counter = 0;

  my $sum = reduce { $a + $b } @array;
  $sums[$topicid] = $sum;

  for (@array){
    my $val = $_/$sum;
    printf OUT "%.4f ", $val;
    $counter++;
  }
  print OUT ("\n");
}
    
    
