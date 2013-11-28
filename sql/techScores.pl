#!/usr/bin/perl -w
use DBI;
use strict;
use warnings;

my  $dsn = "DBI:mysql:database=so;host=localhost;port=3306";

my $dbh = DBI->connect($dsn,'root','') or die "Connection Error: $DBI::errstr\n";

## Technical Impact
## For a given technology, topic, and month:
## For each tag in the technology, what is the sum of tag_scores for that tag
## and topic?

for (my $techID = 1; $techID <= 28; $techID++){
    my $sql = "SELECT TAG_ID from TECHNOLOGIES_TAGS WHERE TECHNOLOGY_ID=$techID;";
    print "$sql\n";
    my $sth = $dbh->prepare($sql);
    $sth->execute or die "SQL Error: $DBI::errstr\n";
    my $tagIDs = "";
    my $count = 0;
    while (my @row = $sth->fetchrow_array) {
        if ($count == 0){
            $tagIDs = "@row";
            $count++;
        } else {
            $tagIDs = "$tagIDs, @row";
        }
    } 
    print "#$tagIDs#\n";
    
    for (my $topicID = 0; $topicID < 60; $topicID++){
        my $sql = "INSERT INTO TECHIMPACT
                    (select $techID, 
                          tsbm.TOPIC_ID, 
                          tsbm.YEAR, 
                          tsbm.MONTH, 
                          tsbm.POST_COUNT, 
                          SUM(tsbm.SUM_WEIGHT), 
                          m.SUM_WEIGHT,
                          SUM(tsbm.SUM_WEIGHT)/m.SUM_WEIGHT  
                   from TAGSCOREBYMONTH tsbm 
                   JOIN QBYMONTH m 
                     ON m.MONTH=tsbm.MONTH 
                      AND m.YEAR=tsbm.YEAR 
                   WHERE tsbm.TAG_ID IN ($tagIDs)
                     AND tsbm.TOPIC_ID=$topicID 
                   group by tsbm.YEAR, tsbm.MONTH);";
        print "$sql\n";
        my $sth = $dbh->prepare($sql);
        $sth->execute or die "SQL Error: $DBI::errstr\n";
    }
}

