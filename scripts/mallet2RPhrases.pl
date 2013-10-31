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
use XML::DOM;
use strict;

# Check arguments
if ($#ARGV != 0){
   print "Usage: $0 topic-phrases.xml \n";
   exit 1;
}

# Open output files
my $infile         = shift;

my $outfile        = "phrases.txt";
my $outfile2       = "phrasesprobs.dat";

open(OUT,      ">$outfile")      or die ("$0: Error: Can't open output file $outfile");
open(OUT2,     ">$outfile2")      or die ("$0: Error: Can't open output file $outfile2");
open(INFILE,   "<$infile") or die ("$0: Error: Can't open input file $infile");


my $parser = XML::DOM::Parser->new();

my $doc = $parser->parsefile($infile);

foreach my $topic ($doc->getElementsByTagName('topic')){

  my $nodes = $topic->getElementsByTagName('phrase');
  my $n = $nodes->getLength;

 for (my $i = 0; $i < $n; $i++){
        my $phrase  = $nodes->item($i)->getFirstChild->getNodeValue;
        my $phrasep  = $nodes->item($i)->getAttribute('weight');
        print OUT "'$phrase' ";
        printf OUT2 "%.6f ", $phrasep;
  }
  print OUT "\n";
  print OUT2 "\n";
}

exit;

