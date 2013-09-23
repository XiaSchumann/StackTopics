#!/usr/bin/perl
use strict;
use lscp;

my $preprocessor = lscp->new;

$preprocessor->setOption("logLevel", "error");
$preprocessor->setOption("inPath", "raw");
$preprocessor->setOption("outPath", "pre");
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
