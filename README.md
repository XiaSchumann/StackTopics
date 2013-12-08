

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
java -jar dist/stacktopics.jar -f ../SO/Sep2013/Posts.xml \
-p ../SO/Sep2013/posts.csv \
-t ../SO/Sep2013/tagstmp.csv \
-m ../SO/Sep2013/posts_tagstmp.csv 
```
(On 15M rows: 840m)



./scripts/preprocessPosts.pl ../SO/Sep2013/posts.csv ../SO/Sep2013/posts-pretmp.csv
###### (On 15M rows: 840m)


#### Prune the uncommon words and tags

./scripts/pruneWords.pl ../SO/Sep2013/posts-pretmp.csv > ../SO/Sep2013/posts-pre.csv
###### (On 15M rows: 5m)

./scripts/pruneTags.pl ../SO/Sep2013/posts_tagstmp.csv > ../SO/Sep2013/posts_tags.csv
###### (On 15M rows: 1m)

./scripts/pruneTags2.pl ../SO/Sep2013/posts_tags.csv ../SO/Sep2013/tagstmp.csv > ../SO/Sep2013/tags.csv
###### (On 15M rows: 1m)

# Add the preprocessed posts into the CSV:

./scripts/createJustPre.pl ../SO/Sep2013/posts-pre.csv > ../SO/Sep2013/import-to-mallet.txt
###### (On 15M rows: 3m)


#### Run LDA on the posts using MALLET

../mallet-2.0.7/bin/mallet import-file \
--input ../SO/Sep2013/import-to-mallet.txt \
--output ../SO/Sep2013/pre.mallet \
--keep-sequence --keep-sequence-bigrams 
###### (On 15M rows: 43m)


../mallet-2.0.7/bin/mallet train-topics \
--config ./scripts/train-topics.conf \
--input ../SO/Sep2013/pre.mallet \
--num-topics 60 \
--output-doc-topics ../SO/Sep2013/60/allfiles.txt \
--output-topic-keys ../SO/Sep2013/60/topics.dat \
--topic-word-weights-file ../SO/Sep2013/60/wordweights.dat \
--word-topic-counts-file ../SO/Sep2013/60/topiccounts.dat \
--xml-topic-phrase-report ../SO/Sep2013/60/topic-phrases.xml
###### (On 15M rows: 1023m)

# Reformat LDA output and load into DB

./scripts/mallet2CSVTheta.pl ../SO/Sep2013/60/allfiles.txt > ../SO/Sep2013/60/theta.csv
#### (On 15M rows: 21m)

./scripts/mallet2CSVWords.pl ../SO/Sep2013/60/topic-phrases.xml ../SO/Sep2013/60/topics.csv
###### (On 15M rows: 1s)


#### Loading the data

Create the DB named "so":

```
mysqladmin -u root create so
```

Fire up the mysql command line:

```
mysql -u root --local-infile=1 so
``` 

Load the schema and data from `sql/schema.ddl`.

Then, in a seperate window, run the Perl script `sql/insertTechnologies.pl` to add all the technology-tag
relationships.

#### Running the analysis queries

Then, run the queries from `sql/queries.sql`. The queries will create a number
of CSV files in `/tmp` that should be moved somewhere sane, like
`results/60/analysis`.

Run sql/topPosts.pl.


#### Creating the graphs for the report

In R, source scripts/makePlots.R (which itself sources a few other files) to 
create the meta plots, impact over time plots, and tech impact over time plots.

In R, source 



#### Creating the webpages

Run ./scripts/buildTopicPage.R. 

Manually create, in results/60/web, techimpact.html, meta.html, and index.html.


#### Tag Analysis

First, run 

./scripts/tagsAndDates.pl \
../SO/Sep2013/posts-pretmp.csv \
../SO/Sep2013/posts_tagstmp.csv \
> ../SO/Sep2013/tagdates.csv

Then, in R, source "scripts/analyzeTags.R". This will create plots and
datafiles.

Then manually create, in results/60/web, tags.html.


#### Other Details and Future work

See the final report that I typed up for Telerik (in Dropbox).

