#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;


if (@ARGV != 2){
    print "Usage: $0 filename out_file \n\n";
    print "This script takes a dump of Stack Overflow, in XML format, and 
outputs a CSV version of this file, to be imported into a DB\n";
    exit;
}
my $file     = shift;
my $out_file = shift;

my $d = '|'; # Delim

my $t=XML::Twig->new(keep_encoding => 1);
$t->parsefile($file); 

my $root= $t->root;

my @lines;
my $count=0;

my @posts = $root->children('row');   # get the para children
foreach my $post (@posts){ 
    my $Id   = $post->{'att'}->{'Id'}; 
    my $PostTyp   = $post->{'att'}->{'PostTypeId'}; 
    my $CreationDate   = $post->{'att'}->{'CreationDate'}; 
    my $Body = $post->{'att'}->{'Body'}; 

    # Remove the extra fluff, e.g., "2008-07-31T21:42:52.667" => "2008-07-31"
    $CreationDate =~ s/T.*//g;
    #my $AcceptedAnswerId   = $post->{'att'}->{'AcceptedAnswerId'}; 
    #my $Score   = $post->{'att'}->{'Score'}; 
    #my $ViewCount   = $post->{'att'}->{'ViewCount'}; 
    #my $AnswerCount   = $post->{'att'}->{'AnswerCount'}; 
    #my $CommentCount   = $post->{'att'}->{'CommentCount'}; 
    #my $FavoriteCount   = $post->{'att'}->{'FavoriteCount'}; 

    $Body =~ tr/\x00-\x7f//cd;
    my $line = "$Id$d$PostTyp$d$CreationDate$d$Body$d\n";
    $lines[$count] = $line;
    $count++;
}

write_file( $out_file, @lines);

