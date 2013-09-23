

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

# Create a CSV file from the XML file:

```
../../StackTopics/scripts/xml2CSV.pl posts.xml posts.csv
```

Preprocess the posts using the lcsp Perl module:

```
../../StackTopics/scripts/stripBody.pl posts.xml raw
../../StackTopics/scripts/preprocessPosts.pl # assumes "raw" input, "pre" output
```

Add the preprocessed posts into the CSV:

```
../../StackTopics/scripts/mergePosts.pl posts.csv pre > posts-pre.csv
```


#### Run LDA on the posts using MALLET

```
../mallet-2.0.7/bin/mallet import-dir --input pre --output pre.mallet --keep-sequence
bin/mallet train-topics --config train-topics.config
```


# TODO: Reformat LDA output and load into DB



#### Loading the data

Create the DB named so:

```
mysqladmin -u root create so
```

Use a script to define the schema

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

