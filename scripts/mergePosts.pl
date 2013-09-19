#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;

if (@ARGV != 2){
    print "Usage: $0 origPosts pre_dir \n";
    exit;
}
my $file     = shift;
my $predir   = shift;


my $t=XML::Twig->new(pretty_print => 'indented');
$t->parsefile($file); 

my $root= $t->root;

my @posts = $root->children('row');   # get the para children
foreach my $post (@posts){ 
    my $id   = $post->{'att'}->{'Id'}; 
    my $body = $post->{'att'}->{'Body'}; 
    #print "ID: $id\n";
    #print "Body: $body\n";
    my $text = read_file( "$predir/$id" ) ;
    $text =~ s/\n/ /g;
    $post->set_att(BodyPre => $text);
}

$t->print;

