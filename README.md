

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

#### Load a directory of XML datafiles (one file per post)

```
java -jar dist/stackanaly.jar com.swtanalytics.stackanaly.main.LoadDirectory DIR_NAME
```


#### Preprocess the posts

```
java -jar dist/stackanaly.jar com.swtanalytics.stackanaly.main.PreProcess 
```

(Note: this is not yet implemented. lcsp must first be ported to a Java library.)

For now, it is assumed that the posts have already been preprocessed when they
are loaded. To do so:

```
./scripts/stripPosts.pl posts.xml raw
./scripts/preprocessPosts.pl raw pre
./scripts/mergePosts.pl posts.xml pre > posts-pre.xml
```

The above methodology depends on the lcsp Perl module.


#### Run LDA on the posts

```
java -jar dist/stackanaly.jar com.swtanalytics.stackanaly.main.RunLDA 
```


#### View LDA output

TODO



Design
======

StackTopics is implemented in Java, using Hibernate to persist data to disk.








Dependencies
============

- Hibernate
- MALLET
- lscp

