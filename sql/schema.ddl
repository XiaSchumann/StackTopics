CREATE TABLE POSTS  ( 
    ID INT NOT NULL,
    POSTTYPE  INT NOT NULL,
    DATE      DATE NOT NULL,
    ORIGTEXT  TEXT,
    PRETEXT   TEXT 
);

CREATE TABLE TAGS (
    ID INT NOT NULL,
    LABEL VARCHAR(100)
);

CREATE TABLE TAGCOUNT (
    TAG_ID INT NOT NULL,
    COUNT INT 
);

CREATE TABLE POSTS_TAGS (
    POST_ID INT NOT NULL,
    TAG_ID INT NOT NULL
);

CREATE TABLE TOPICS (
    ID INT NOT NULL,
    ALPHA FLOAT NOT NULL,
    NUMTOKENS INT NOT NULL,
    TOPWORDS VARCHAR(500) NOT NULL,
    TOPPRHASES VARCHAR(500) NOT NULL
);

CREATE TABLE THETA (
    POST_ID INT NOT NULL,
    TOPIC_ID INT NOT NULL,
    WEIGHT FLOAT NOT NULL
);

CREATE TABLE THETA2 (
    POST_ID INT NOT NULL,
    POSTTYPE  INT NOT NULL,
    DATE      DATE NOT NULL,
    TOPIC_ID INT NOT NULL,
    WEIGHT FLOAT NOT NULL
);

CREATE TABLE METRICS (
    ID INT NOT NULL,
    NAME VARCHAR(20) NOT NULL,
    DESCRIPTION VARCHAR(500)
);

CREATE TABLE TOPICMETRICS (
    TOPIC_ID INT NOT NULL,
    METRIC_ID INT NOT NULL,
    DATE DATE,
    VALUE FLOAT NOT NULL
);

CREATE TABLE TOPICMETRICS2 (
    TOPIC_ID INT NOT NULL,
    METRIC_ID INT NOT NULL,
    DATE DATE,
    VALUE FLOAT NOT NULL
);

CREATE TABLE TAGSCORE (
    TOPIC_ID INT NOT NULL,
    LABEL VARCHAR(100),
    TAG_ID INT NOT NULL,
    POST_COUNT INT NOT NULL,
    SUM_WEIGHT FLOAT NOT NULL,
    AVG_WEIGHT FLOAT NOT NULL
);

CREATE TABLE TECHIMPACT (
    TECHNOLOGY_ID INT NOT NULL,
    TOPIC_ID INT NOT NULL,
    YEAR INT NOT NULL,
    MONTH INT NOT NULL,
    POST_COUNT INT NOT NULL,
    SUM_WEIGHT FLOAT NOT NULL,
    MONTH_WEIGHT FLOAT NOT NULL,
    AVG_WEIGHT FLOAT NOT NULL
);

CREATE TABLE TAGSCOREBYMONTH (
    TOPIC_ID INT NOT NULL,
    TAG_ID INT NOT NULL,
    YEAR INT NOT NULL,
    MONTH INT NOT NULL,
    POST_COUNT INT NOT NULL,
    SUM_WEIGHT FLOAT NOT NULL,
    AVG_WEIGHT FLOAT NOT NULL
);


CREATE TABLE MONTHS (
    YEAR INT NOT NULL,
    MONTH INT NOT NULL,
    POST_COUNT INT NOT NULL
);

CREATE TABLE QBYMONTH (
    YEAR INT NOT NULL,
    MONTH INT NOT NULL,
    POST_COUNT INT NOT NULL,
    SUM_WEIGHT INT NOT NULL
);

CREATE TABLE DATEOFTAGSFIRSTAPPEARANCE (
    TAG_ID INT NOT NULL,
    DATE DATE NOT NULL
);


CREATE TABLE TECHNOLOGIES (
    ID INT NOT NULL AUTO_INCREMENT,
    GROUP_ID INT NOT NULL,
    LABEL VARCHAR(100),
    PRIMARY KEY (ID)
) ENGINE=MyISAM;

CREATE TABLE TECHNOLOGIES_TAGS (
    TECHNOLOGY_ID INT NOT NULL,
    TAG_ID INT NOT NULL
);



LOAD DATA LOCAL INFILE '/dataware/tmp2/tmp/SO/Sep2013/posts-pre.csv' INTO TABLE POSTS FIELDS TERMINATED BY '|';
LOAD DATA LOCAL INFILE '/dataware/tmp2/tmp/SO/Sep2013/60/topics.csv' INTO TABLE TOPICS FIELDS TERMINATED BY '|';
LOAD DATA LOCAL INFILE '/dataware/tmp2/tmp/SO/Sep2013/60/theta.csv' INTO TABLE THETA FIELDS TERMINATED BY '|';
LOAD DATA LOCAL INFILE '/dataware/tmp2/tmp/SO/Sep2013/tags.csv' INTO TABLE TAGS FIELDS TERMINATED BY '|';
LOAD DATA LOCAL INFILE '/dataware/tmp2/tmp/SO/Sep2013/posts_tags.csv' INTO TABLE POSTS_TAGS FIELDS TERMINATED BY '|';

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



ALTER TABLE POSTS ADD PRIMARY KEY (ID);
ALTER TABLE TOPICS ADD PRIMARY KEY (ID);
ALTER TABLE METRICS ADD PRIMARY KEY (ID);
ALTER TABLE TECHNOLOGIES_TAGS ADD UNIQUE INDEX(TECHNOLOGY_ID, TAG_ID);

CREATE INDEX postsindex ON POSTS (ID);
CREATE INDEX thetaindex ON THETA (POST_ID);
CREATE INDEX thetadindex ON THETA (DATE);
CREATE INDEX tagindex ON TAGS (ID);
CREATE INDEX pindex ON POSTS_TAGS (POST_ID);
CREATE INDEX tindex ON POSTS_TAGS (TAG_ID);
CREATE INDEX dindex ON POSTS (DATE);


