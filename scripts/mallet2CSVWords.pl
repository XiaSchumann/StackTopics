#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;


if (@ARGV != 2){
    print "Usage: $0 in_file out_file \n\n";
    exit;
}
my $file     = shift;
my $out_file = shift;

my $t=XML::Twig->new(keep_encoding => 1);
$t->parsefile($file); 

my $root= $t->root;

my @lines;
my $count=0;

my @topics = $root->children('topic');   # get the para children
foreach my $topic (@topics){ 
    my $id            = $topic->{'att'}->{'id'}; 
    my $alpha         = scalar($topic->{'att'}->{'alpha'}); 
    my $totalTokens   = $topic->{'att'}->{'totalTokens'}; 
    my $titles        = $topic->{'att'}->{'titles'}; 

    my $topWords = "";

    my @words = $topic->children('word');   # get the para children
    foreach my $word (@words){ 
        my $txt   = $word->text;
        $topWords = "$topWords $txt";
    }

    my $line = sprintf "%s|%.4f|%s|%s|%s\n", $id, $alpha, $totalTokens, $topWords, $titles;
    $lines[$count] = $line;
    $count++;
}

write_file( $out_file, @lines);

