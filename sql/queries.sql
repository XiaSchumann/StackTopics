###########################################################################
# SWT Analytics
# 2013
###########################################################################


###########################################################################
## Define metrics
###########################################################################

INSERT INTO METRICS VALUES 
(1, "Share", "The proportion of posts that contain the topic.");

INSERT INTO METRICS VALUES 
(2, "Impact", "The proportion of posts that contain the topic in a given month.");


###########################################################################
## Define technologies
###########################################################################

INSERT INTO TECHNOLOGIES (GROUP_ID, LABEL) VALUES 
(1, "c#-learning"), 
(1, "c++-learning"),
(1, "java-learning"),
(1, "python-learning"),
(1, "php-learning"),
(1, "javascript-learning"),

(2, "oracle"), 
(2, "mysql"), 
(2, "sql-server"), 
(2, "sqlite"), 
(2, "postgresql"), 

(3, "git"), 
(3, "svn"), 

(4, "android"), 
(4, "iphone"), 
(4, "blackberry"), 
(4, "windows-phone"), 

(5, "php-scripting"), 
(5, "python-scripting"), 
(5, "perl-scripting"), 
(5, "javascript-scripting"), 
(5, "bash-scripting"), 

(6, "javascript-web"), 
(6, "asp.net-web"), 
(6, "php-web"), 
(6, "jquery-web"), 

(7, "eclipse"), 
(7, "netbeans"); 


CALL addAssociation("c#-learning", "c#4.0")

###########################################################################
## Setup helper tables and stuff
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



###########################################################################
## Tag Analysis
###########################################################################


## New (unique) tags per month
# First, find the first month for each tag...

INSERT INTO DATEOFTAGSFIRSTAPPEARANCE (
    `TAG_ID`, `DATE`
)
SELECT 
    t.ID as TagID, 
    MIN(p.DATE) as FirstDate
FROM POSTS_TAGS pt
JOIN POSTS p
    ON p.ID = pt.POST_ID
JOIN TAGS t
    ON t.ID = pt.TAG_ID
GROUP BY TagID;


# ... then, count IDs per date

SELECT
    COUNT(TAG_ID) as NewTagCount,
    YEAR(DATE) as YEAR,
    MONTH(DATE) as MONTH
FROM DATEOFTAGSFIRSTAPPEARANCE 
GROUP BY YEAR(DATE), MONTH(DATE)
INTO OUTFILE '/tmp/newtagcount.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



## Total tag count in desc order

SELECT 
    COUNT(pt.TAG_ID) as TagCount,
    t.LABEL as TagLabel 
FROM POSTS_TAGS pt
JOIN POSTS p
    ON p.ID = pt.POST_ID
JOIN TAGS t
    ON t.ID = pt.TAG_ID
GROUP BY pt.TAG_ID
ORDER BY TagCount DESC
INTO OUTFILE '/tmp/totaltagcount.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



###########################################################################
## Topic metrics
###########################################################################


## Topic share:

INSERT INTO TOPICMETRICS
(
    `TOPIC_ID`, `METRIC_ID`, `DATE`, `VALUE`
)
SELECT 
    t.TOPIC_ID as TopicID, 
    1 as MetricID, 
    "0000-00-00" as Date, 
    SUM(t.WEIGHT)/@NUM_POSTS as Value
FROM POSTS p
JOIN THETA t
    ON t.POST_ID = p.ID
GROUP BY TopicID;



## Topic impact:

INSERT INTO TOPICMETRICS
(
    `TOPIC_ID`, `METRIC_ID`, `DATE`, `VALUE`
)
SELECT t.TOPIC_ID as TopicID, 2 as MetricID, MIN(p.DATE) as Date, SUM(t.WEIGHT)/m.POST_COUNT as
Value
FROM POSTS p
JOIN THETA t
  ON t.POST_ID = p.ID
JOIN MONTHS m
  ON    YEAR(p.DATE) = m.YEAR
    AND MONTH(p.DATE) = m.MONTH
GROUP BY TopicID, YEAR(p.DATE), MONTH(p.DATE);



## Tag score:

# For each combination of topic and tag, find all posts that both
# contain that topic and tag, and compute the the sum and avg of the weights
# that those posts have in that topic

SELECT 
    th.TOPIC_ID as TopicID,
    t.LABEL as TagLabel,
    pt.TAG_ID as TagID,
    COUNT(pt.POST_ID) as PostCount,
    SUM(th.WEIGHT) as WeightSum,
    AVG(th.WEIGHT) as WeightAvg
FROM POSTS_TAGS pt
JOIN POSTS p
    ON p.ID = pt.POST_ID
JOIN TAGS t
    ON t.ID = pt.TAG_ID
JOIN THETA th
    on th.POST_ID = pt.POST_ID
GROUP BY th.TOPIC_ID, pt.TAG_ID
ORDER BY th.TOPIC_ID, WeightSum DESC, pt.TAG_ID
INTO OUTFILE '/tmp/tagscore.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



## Technical Impact

# TODO





###########################################################################
###########################################################################

## TODO:
# SELECT * FROM POSTS WHERE P_ORIGTEXT LIKE "%telerik%";

## TODO: How to find out what posts a topic has, in order

## TODO: How to find out what posts a post has, in order



###########################################################################
## Output files so that R can use them
###########################################################################

SELECT  COUNT(ID) as NumPosts, DATE  Month, POSTTYPE as Type 
FROM    POSTS
GROUP BY YEAR(DATE), MONTH(DATE), Type
INTO OUTFILE '/tmp/out.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';
