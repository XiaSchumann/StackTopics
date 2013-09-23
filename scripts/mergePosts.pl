#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;

if (@ARGV != 2){
    print "Usage: $0 csv pre_dir \n";
    exit;
}
my $file     = shift;
my $predir   = shift;

my $d = '|';

open (IN, "<", $file) or die();

while (<IN>){
    chomp;
    my @c = split /\|/;
    my $id   = $c[0];
    my $text = read_file( "$predir/$id" ) ;
    chomp $text;
    print "$_$text$d\n";
}




