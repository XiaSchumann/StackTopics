#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;

if (@ARGV != 3){
    print "Usage: $0 filename out_file1 out_file2 \n\n";
    exit;
}
my $file      = shift;
my $out_file  = shift;
my $out_file2 = shift;

my $d = '|'; # Delim

my $t=XML::Twig->new(keep_encoding => 1);
$t->parsefile($file); 

my $root= $t->root;

my @lines;
my $count=0;
my $tagCount=0;
my %tags;

my @posts = $root->children('row');   # get the para children
foreach my $post (@posts){ 
    my $Id   = $post->{'att'}->{'Id'}; 
    my $Tags = $post->{'att'}->{'Tags'}; 

    $Tags =~ s/&lt;//g;

    my @taglist = split /&gt;/, $Tags;

    foreach my $t (@taglist){
        if (not exists $tags{$t}){
            $tags{$t} = $tagCount++;
        }

        my $line = "$Id$d$tags{$t}\n";
        $lines[$count] = $line;
        $count++;
    }
}

write_file( $out_file, @lines);


my @tagLines;
$count = 0;
# Now write out the tags and their IDs
foreach my $id (sort keys %tags){
    my $line = "$tags{$id}$d$id\n";
    $tagLines[$count] = $line;
    $count++;
}

write_file( $out_file2, @tagLines);

