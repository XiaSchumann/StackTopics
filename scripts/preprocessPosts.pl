#!/usr/bin/perl
use strict;
use lscp;


if (@ARGV != 2){
    print "Usage: $0 raw_dir pre_dir \n";
    exit;
}
my $rawDir   = shift;
my $preDir   = shift;

my $preprocessor = lscp->new;

$preprocessor->setOption("logLevel", "error");
$preprocessor->setOption("inPath", $rawDir);
$preprocessor->setOption("outPath", $preDir);
$preprocessor->setOption("oneInputFile", 1);
$preprocessor->setOption("oneOutputFile", 1);
$preprocessor->setOption("isCode", 0);
$preprocessor->setOption("doTokenize", 0);
$preprocessor->setOption("doStemming", 1);
$preprocessor->setOption("doRemoveDigits", 1);
$preprocessor->setOption("doLowerCase", 1);
$preprocessor->setOption("doRemovePunctuation", 1);
$preprocessor->setOption("doRemoveSmallWords", 1);
$preprocessor->setOption("doStopwordsEnglish", 1);
$preprocessor->setOption("doRemoveURLs", 1);
$preprocessor->setOption("doRemoveCodeTags", 1);
$preprocessor->setOption("doRemoveHTMLTags", 1);
$preprocessor->setOption("doExpandContractions", 1);
$preprocessor->setOption("doOutputOneWordPerLine", 0);

$preprocessor->preprocess();
