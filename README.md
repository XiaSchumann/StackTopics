

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
java -jar dist/stacktopics.jar -f ../SO/June2010/med/posts.xml \
-p ../SO/June2010/med/posts.csv \
-t ../SO/June2010/med/tags.csv \
-m ../SO/June2010/med/posts_tags.csv 
```
(On 500K rows: 3m)

```
java -jar dist/stacktopics.jar -f ../SO/Sep2013/Posts.xml \
-p ../SO/Sep2013/posts.csv \
-t ../SO/Sep2013/tags.csv \
-m ../SO/Sep2013/posts_tags.csv 
```
(On 15M rows: 840m)

```
./scripts/preprocessPosts.pl ../SO/Sep2013/posts.csv ../SO/Sep2013/posts-pre.csv
```
(On 500K rows: 17m)
(On 15M rows: 840m)


# Add the preprocessed posts into the CSV:

```
./scripts/createJustPre.pl ../SO/Sep2013/posts-pre.csv > ../SO/Sep2013/import-to-mallet.txt
```
(On 15M rows: 3m)




#### Run LDA on the posts using MALLET

```
../mallet-2.0.7/bin/mallet import-file \
--input ../SO/Sep2013/import-to-mallet.txt \
--output ../SO/Sep2013/pre.mallet \
--keep-sequence --keep-sequence-bigrams 
```
(On 15M rows: 43m)


```
../mallet-2.0.7/bin/mallet train-topics \
--config ./scripts/train-topics.conf \
--input ../SO/Sep2013/pre.mallet \
--num-topics 60 \
--output-doc-topics ../SO/Sep2013/60/allfiles.txt \
--output-topic-keys ../SO/Sep2013/60/topics.dat \
--topic-word-weights-file ../SO/Sep2013/60/wordweights.dat \
--word-topic-counts-file ../SO/Sep2013/60/topiccounts.dat \
--xml-topic-phrase-report ../SO/Sep2013/60/topic-phrases.xml
```
(On 500K rows: 59m)
(On 15M rows: 1023m)

../mallet-2.0.7/bin/mallet train-topics \
--config ./scripts/train-topics.conf \
--num-topics 100 \
--input ../SO/Sep2013/pre.mallet \
--output-doc-topics ../SO/Sep2013/100/allfiles.txt \
--output-topic-keys ../SO/Sep2013/100/topics.dat \
--topic-word-weights-file ../SO/Sep2013/100/wordweights.dat \
--word-topic-counts-file ../SO/Sep2013/100/topiccounts.dat \
--xml-topic-phrase-report ../SO/Sep2013/100/topic-phrases.xml


../mallet-2.0.7/bin/mallet train-topics \
--config ./scripts/train-topics.conf \
--num-topics 200 \
--input ../SO/Sep2013/pre.mallet \
--output-doc-topics ../SO/Sep2013/200/allfiles.txt \
--output-topic-keys ../SO/Sep2013/200/topics.dat \
--topic-word-weights-file ../SO/Sep2013/200/wordweights.dat \
--word-topic-counts-file ../SO/Sep2013/200/topiccounts.dat \
--xml-topic-phrase-report ../SO/Sep2013/200/topic-phrases.xml


# Reformat LDA output and load into DB


```
./scripts/mallet2CSVTheta.pl ../SO/Sep2013/60/allfiles.txt > ../SO/Sep2013/60/theta.csv
```
(On 500K rows: 24s)
(On 15M rows: 21m)


```
./scripts/mallet2CSVWords.pl ../SO/Sep2013/60/topic-phrases.xml ../SO/Sep2013/60/topics.csv
```
(On 500K rows: 1s)
(On 15M rows: 1s)


#### Loading the data

Create the DB named "so":

```
mysqladmin -u root create so
```

Fire up the mysql command line:

```
mysql -u root --local-infile=1 so
``` 

Load the schema from `sql/schema.ddl`.

Then, in a seperate window, run the Perl script `sql/insertTechnologies.pl` to add all the technology-tag
relationships.

Then, run the queries from `sql/queries.sql`.




Design
======






Dependencies
============

- Hibernate
- MALLET
- lscp

