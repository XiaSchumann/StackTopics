#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;


if (@ARGV != 2){
    print "Usage: $0 filename out_dir \n\n";
    print "This script takes a dump of Stack Overflow, in XML format, and 
outputs one file per post (named by the ID of the post) into the
given directory. Each file contains only the body of the post. \n";
    exit;
}
my $file     = shift;
my $outdir   = shift;

my $d = '|'; # Delim

`mkdir -p $outdir`;

my $t=XML::Twig->new();
$t->parsefile($file); 
my $root= $t->root;

my @posts = $root->children('row');   # get the para children
foreach my $post (@posts){ 
    my $Id   = $post->{'att'}->{'Id'}; 
    my $PostTyp   = $post->{'att'}->{'PostTypeId'}; 
    my $CreationDate   = $post->{'att'}->{'CreationDate'}; 
    my $Body = $post->{'att'}->{'Body'}; 
    #my $AcceptedAnswerId   = $post->{'att'}->{'AcceptedAnswerId'}; 
    #my $Score   = $post->{'att'}->{'Score'}; 
    #my $ViewCount   = $post->{'att'}->{'ViewCount'}; 
    #my $AnswerCount   = $post->{'att'}->{'AnswerCount'}; 
    #my $CommentCount   = $post->{'att'}->{'CommentCount'}; 
    #my $FavoriteCount   = $post->{'att'}->{'FavoriteCount'}; 

    $Body =~ tr/\x00-\x7f//cd;
    write_file( "$outdir/$Id", "$Body");
}

