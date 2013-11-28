#!/usr/bin/perl -w
use DBI;
use strict;
use warnings;

my  $dsn = "DBI:mysql:database=so;host=localhost;port=3306";

my $dbh = DBI->connect($dsn,'root','') or die "Connection Error: $DBI::errstr\n";

mkdir "/tmp/topposts";

for (my $i= 0; $i < 60; $i++){

    my $sql = "select * from THETA where TOPIC_ID=$i ORDER BY WEIGHT DESC LIMIT 100 INTO OUTFILE '/tmp/topposts/$i.csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';";
    print "$sql\n";
    my $sth = $dbh->prepare($sql);
    $sth->execute or die "SQL Error: $DBI::errstr\n";
}
