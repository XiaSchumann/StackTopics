###########################################################################
# SWT Analytics
# 2013
###########################################################################


###########################################################################
## Setup helper tables
###########################################################################


INSERT INTO MONTHS
(
    `YEAR`, `MONTH`, `POST_COUNT`
)
SELECT
    YEAR(DATE) as YEAR,
    MONTH(DATE) as MONTH,
    COUNT(*) as POST_COUNT
FROM POSTS 
GROUP BY YEAR(DATE), MONTH(DATE);

SELECT SUM(m.POST_COUNT) FROM MONTHS m INTO @NUM_POSTS;

INSERT INTO QBYMONTH
(
    `YEAR`, `MONTH`, `POST_COUNT`, `SUM_WEIGHT` 
)
SELECT
    YEAR(th.DATE) as YEAR,
    MONTH(th.DATE) as MONTH,
    COUNT(th.POSTTYPE) as POST_COUNT,
    SUM(th.WEIGHT) as SUM_WEIGHT
FROM THETA th
    WHERE th.POSTTYPE=1
GROUP BY YEAR(DATE), MONTH(DATE);


INSERT INTO THETA2
(
    `POST_ID`, `POSTTYPE`, `DATE`, `TOPIC_ID`, `WEIGHT`
)
SELECT
    th.POST_ID,
    p.POSTTYPE,
    p.DATE,
    th.TOPIC_ID,
    th.WEIGHT
FROM THETA th
JOIN POSTS p
    ON p.ID = th.POST_ID;

DROP TABLE THETA;
RENAME TABLE THETA2 to THETA;



###########################################################################
## General Analyses
###########################################################################

SELECT  COUNT(ID) as NumPosts, DATE  Month, POSTTYPE as Type 
FROM    POSTS
GROUP BY YEAR(DATE), MONTH(DATE), Type
INTO OUTFILE '/tmp/numpostsbymonth.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



###########################################################################
## Tag Analysis
###########################################################################

## Remove tags with less than 100 posts

## New (unique) tags per month
# First, find the first month for each tag...
TRUNCATE TABLE DATEOFTAGSFIRSTAPPEARANCE;
INSERT INTO DATEOFTAGSFIRSTAPPEARANCE (
    `TAG_ID`, `DATE`
)
SELECT 
    pt.TAG_ID as TAG_ID, 
    MIN(p.DATE) as DATE
FROM POSTS_TAGS pt
JOIN POSTS p
    ON p.ID = pt.POST_ID
GROUP BY TAG_ID;


# ... then, count IDs per date

SELECT
    COUNT(TAG_ID) as NewTagCount,
    YEAR(DATE) as YEAR,
    MONTH(DATE) as MONTH
FROM DATEOFTAGSFIRSTAPPEARANCE 
GROUP BY YEAR(DATE), MONTH(DATE)
INTO OUTFILE '/tmp/newtagcountbymonth.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



## Total tag count in desc order

SELECT 
    COUNT(pt.TAG_ID) as TagCount,
    t.LABEL as TagLabel 
FROM POSTS_TAGS pt
JOIN TAGS t
    ON t.ID = pt.TAG_ID
GROUP BY pt.TAG_ID
ORDER BY TagCount DESC
INTO OUTFILE '/tmp/totaltagcountbytag.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



###########################################################################
## Topic metrics
###########################################################################


## Topic share:

SELECT
    TOPIC_ID as TopicID, 
    COUNT(TOPIC_ID) as NumPosts, 
    SUM(WEIGHT)/@NUM_POSTS as Share,
    (SELECT COUNT(*) FROM THETA WHERE TOPIC_ID=TopicID AND POSTTYPE=1) as PerQ,
    (SELECT COUNT(*) FROM THETA WHERE TOPIC_ID=TopicID AND POSTTYPE=2) as PerA
FROM THETA
GROUP BY TopicId
ORDER BY Share
INTO OUTFILE '/tmp/topicshare.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';


## Topic impact:

INSERT INTO TOPICMETRICS
(
    `TOPIC_ID`, `METRIC_ID`, `DATE`, `VALUE`
)
SELECT 
    th.TOPIC_ID as TopicID, 
    2 as MetricID, 
    MIN(th.DATE) as Date, 
    SUM(th.WEIGHT)/m.POST_COUNT as Value
FROM THETA th
JOIN MONTHS m
  ON    YEAR(th.DATE) = m.YEAR
    AND MONTH(th.DATE) = m.MONTH
GROUP BY TopicID, YEAR(th.DATE), MONTH(th.DATE);


SELECT  *
FROM    TOPICMETRICS
WHERE METRIC_ID = 2
INTO OUTFILE '/tmp/topicimpactbymonth.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';


## Tag score:

# For each combination of topic and tag, find all posts that both
# contain that topic and tag, and compute the the sum and avg of the weights
# that those posts have in that topic
TRUNCATE TABLE TAGSCORE;
INSERT INTO TAGSCORE
(
    `TOPIC_ID`, `LABEL`, `TAG_ID`, `POST_COUNT`, `SUM_WEIGHT`, `AVG_WEIGHT`
)
SELECT 
    th.TOPIC_ID as TopicID,
    t.LABEL as TagLabel,
    pt.TAG_ID as TagID,
    COUNT(pt.POST_ID) as PostCount,
    SUM(th.WEIGHT) as WeightSum,
    AVG(th.WEIGHT) as WeightAvg
FROM POSTS_TAGS pt
JOIN TAGS t
    ON t.ID = pt.TAG_ID
JOIN THETA th
    on th.POST_ID = pt.POST_ID
GROUP BY th.TOPIC_ID, pt.TAG_ID
ORDER BY th.TOPIC_ID, WeightSum DESC, pt.TAG_ID;


SELECT  *
FROM    TAGSCORE
INTO OUTFILE '/tmp/tagscore.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';



## Tag score per month:

# Same as above, except broken down by year and month

TRUNCATE TABLE TAGSCOREBYMONTH;
INSERT INTO TAGSCOREBYMONTH
(
    `TOPIC_ID`, `TAG_ID`, `YEAR`, `MONTH`, `POST_COUNT`, `SUM_WEIGHT`, `AVG_WEIGHT`
)
SELECT 
    th.TOPIC_ID as TopicID,
    pt.TAG_ID as TagID,
    YEAR(th.DATE) as Year,
    MONTH(th.DATE) as Month,
    COUNT(pt.POST_ID) as PostCount,
    SUM(th.WEIGHT) as WeightSum,
    AVG(th.WEIGHT) as WeightAvg
FROM POSTS_TAGS pt
JOIN THETA th
    on th.POST_ID = pt.POST_ID
GROUP BY th.TOPIC_ID, pt.TAG_ID, YEAR(th.DATE), MONTH(th.DATE)
ORDER BY th.TOPIC_ID, YEAR(th.DATE), MONTH(th.DATE), WeightSum DESC, pt.TAG_ID;

SELECT  *
FROM    TAGSCOREBYMONTH
INTO OUTFILE '/tmp/tagscorebymonth.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



## Technical Impact: First run the script sql/techImpact

SELECT *
FROM TECHIMPACT
INTO OUTFILE '/tmp/techimpact.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

SELECT *
FROM TECHNOLOGIES
INTO OUTFILE '/tmp/technologies.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

SELECT *
FROM TECHNOLOGIES_TAGS
INTO OUTFILE '/tmp/technologies_tags.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';
