#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;

if (@ARGV != 2){
    print "Usage: $0 filename out_dir \n";
    exit;
}
my $file     = shift;
my $outdir   = shift;

`mkdir -p $outdir`;

my $t=XML::Twig->new();
$t->parsefile($file); 

my $root= $t->root;

my @posts = $root->children('row');   # get the para children
foreach my $post (@posts){ 
    my $id   = $post->{'att'}->{'Id'}; 
    my $body = $post->{'att'}->{'Body'}; 
    #print "ID: $id\n";
    #print "Body: $body\n";
    $body =~ tr/\x00-\x7f//cd;
    write_file( "$outdir/$id", $body);
}        

