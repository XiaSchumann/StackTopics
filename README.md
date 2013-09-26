

StackTopics
=======================

Analyze the textual content of the millions of Stack Overflow posts.


Summary
=======

StackTopics uses NLP techniques and latent Dirichlet allocation (LDA) to analyze
the textual content of the millions of Stack Overflow posts.

Still under early development.


Usage
=====

Assumptions:

- All commands are being run out of this directory.
- There is a directory named ../SO/Sep2013 that contains the Stack Overflow
  data dump.
- MALLET has been downloaded and unzipped to the directory "../mallet-2.0.7"


# Create a CSV file from the XML file (posts):

```
./scripts/xml2CSV.pl ../SO/June2010/med/posts.xml ../SO/June2010/med/posts.csv
```
(On 500K rows: 70s)

# Create a CSV file from the XML file (tags):

```
./scripts/xml2CSVTags.pl ../SO/June2010/med/posts.xml ../SO/June2010/med/tags.csv ../SO/June2010/med/posts_tags.csv
```
(On 500K rows: 60s)


# Preprocess the posts using the lcsp Perl module:

```
./scripts/stripBody.pl ../SO/June2010/med/posts.xml ../SO/June2010/med/raw
```
(On 500K rows: 120s)

```
./scripts/preprocessPosts.pl ../SO/June2010/med/raw ../SO/June2010/med/pre
```
(On 500K rows: 17m)


# Add the preprocessed posts into the CSV:

```
./scripts/mergePosts.pl ../SO/June2010/med/posts.csv ../SO/June2010/med/pre > ../SO/June2010/med/posts-pre.csv
```
(On 500K rows: 10m)




#### Run LDA on the posts using MALLET

```
../mallet-2.0.7/bin/mallet import-dir \
--input ../SO/June2010/med/pre \
--output ../SO/June2010/med/pre.mallet \
--keep-sequence --gram-sizes 1,2 --keep-sequence-bigrams 
```
(On 500K rows: 3m)


```
../mallet-2.0.7/bin/mallet train-topics \
--config ./scripts/train-topics.conf \
--input ../SO/June2010/med/pre.mallet \
--output-doc-topics ../SO/June2010/med/allfiles.txt \
--xml-topic-phrase-report ../SO/June2010/med/topic-phrases.xml
```
(On 500K rows: 59m)


# Reformat LDA output and load into DB


```
./scripts/mallet2CSVTheta.pl ../SO/June2010/med/allfiles.txt > ../SO/June2010/med/theta.csv
```
(On 500K rows: 24s)


```
./scripts/mallet2CSVWords.pl ../SO/June2010/med/topic-phrases.xml ../SO/June2010/med/topics.csv
```
(On 500K rows: 1s)


#### Loading the data

Create the DB named "so":

```
mysqladmin -u root create so
```

Fire up the mysql command line:

```
mysql -u root --local-infile=1 so
``` 

Then see `sql/` directory.





Design
======









Dependencies
============

- Hibernate
- MALLET
- lscp

