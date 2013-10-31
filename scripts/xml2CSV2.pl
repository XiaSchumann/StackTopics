#!/usr/bin/perl
use strict;
use XML::Twig;
use File::Slurp;
use XML::LibXML::Reader;


if (@ARGV != 2){
    print "Usage: $0 filename out_file \n\n";
    print "This script takes a dump of Stack Overflow, in XML format, and 
outputs a CSV version of this file, to be imported into a DB\n";
    exit;
}
my $file     = shift;
my $out_file = shift;

my $d = '|'; # Delim

my @lines;
my $count = 0;

open(IN, "<$file") or die();

<IN>;
<IN>;

while (<IN>){
        chomp;

        my $Id             = $_;
        $Id =~ s/.*Id="(.*)" PostTypeId=".*/$1/;
        
        my $PostType        = $_;
        $PostType =~ s/.*PostTypeId="(.*)" ParentId=".*/$1/;
        #my $CreationDate   = $reader->getAttribute('CreationDate'); 
        #my $Body           = $reader->getAttribute('Body'); 
         

        # Remove the extra fluff, e.g., "2008-07-31T21:42:52.667" => "2008-07-31"
        #$CreationDate =~ s/T.*//g;

        #$Body =~ tr/\x00-\x7f//cd;
        #my $line = "$Id$d$PostTyp$d$CreationDate$d$Body$d\n";
        my $line = "$Id$d$PostType$d\n";
        $lines[$count] = $line;
        $count++;
}

write_file( $out_file, @lines);

