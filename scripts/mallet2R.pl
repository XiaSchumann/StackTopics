#!/usr/bin/perl
#
# Stephen W. Thomas
# sthomas@cs.queensu.ca
# http://research.cs.queensu.ca/~sthomas/
# Software Analysis and Intelligence Lab (SAIL)
# School of Computing, Queen's University, Canada
#
#
# Last updated March 2010
#
#
# Reformats Mallet's large, weird output files into something usable by other
# programs, like R.
#
################################################################################

use File::Basename;


# Check argumets
if ($#ARGV > 0 ){ 
   print "$0: Error: Incorrect usage.\n";
   print "$0 [settings]\n";
   print "( By default, settings.pl should be in current dir )\n";
   print "Exiting.\n";
   exit 1;  
}


$settings="settings.pl";
$settings=$ARGV[0] if ($#ARGV > -1);


# Defaults
$inference              = 0;
$myN                    = 0;
$inName                 = "allfiles1.txt";
$doTime                 = 0;
$codeVersionMap         = "";
$doAdvancedCodeStats    = 0;
$doMail                 = 0;
$doAdvancedMailStats    = 0;
$doNumWords             = 0;
$fileExtension          = "c";
$doYs                   = 0;
$doOnlyName             = 0;
sub stripVersion{}
require($settings);


if ($doTime == 1){
    print "$0: Log: Reading code version map.\n";
    open(INFILE,  "<$codeVersionMap") or die ("$0: Error: Can't open input file $codeVersionMap");
    while(<INFILE>){
        chomp;
        @c = split; 
        $hash{$c[2]} = $c[1];
    }
    close(INFILE);
}


if ($doMail == 1){
    open(MAILDATA, ">mail.dat")         or die ("$0: Error: Can't open output file.");
    open(MAILFILE, ">mail.files.dat")   or die ("$0: Error: Can't open output file.");

    if ($doAdvancedMailStats == 1){
        print "$0: Log: Reading thread log (reading $threadStatsFile).\n";
        open(INFILE,  "<$threadStatsFile") or die ("$0: Error: Can't open input file $threadStatsFile");
        while(<INFILE>){
            chomp;
            @c = split; 
            $wc{$c[0]}      = $c[1];
            $num{$c[0]}     = $c[2];
            $start{$c[0]}   = $c[3];
            $end{$c[0]}     = $c[4];
            $dur{$c[0]}     = $c[5];
        }
        close(INFILE);
    }
}


open(INFILE,   "<$inName")          or die ("$0: Error: Can't open input file $inName");
open(CODEDATA, ">code.dat")         or die ("$0: Error: Can't open output file.");
open(CODEFILE, ">code.files.dat")   or die ("$0: Error: Can't open output file.");

if ($inference==0){
    print "$0: Log: Reformatting train-topics file.\n";
    reformat2();
} else {
    print "$0: Log: Reformatting inference file.\n";
    reformat ();
}

print "$0: Log: Done.\n";

exit;


################################################################################
################################################################################
# Reformat the allfiles1.txt (output of train-topics)
################################################################################
################################################################################
sub reformat2 {
    while (<INFILE>){
        if (/^#/){ }   # Skip comments
        else{
            chomp;
            @cols        = split;
            $curFileIdx  = $cols[0]; 
            $curFileName = $cols[1]; 

            $isCode=1;
            if ($doMail == 1){
                if ($curFileName =~ /mailing_list/){
                    $isCode=0;
                }
            }

            my @data = ();
            $N = (scalar(@cols)-2)/2;   # number of cols

            if ($myN != 0){ 
                for($i=0;$i<$myN;$i++){ $data[$i] = 0; }
            } else {
                for($i=0;$i<$N;$i++){ $data[$i] = 0; }
            }

            # The lines have topic amount topic amount ... 
            for ($i=2;$i<=$N+2;$i+=2){
                $topic  = scalar($cols[$i]);
                $weight = scalar($cols[$i+1]); 
                $data[$topic] = $weight;
            }   

            if ($isCode==1){
                foreach (@data){ printf CODEDATA "%.4f ", $_; }
                print CODEDATA "\n";
            
                printCodeStats($curFileIdx, $curFileName);
            } else {
                foreach (@data){ printf MAILDATA "%.4f ", $_; }
                print MAILDATA "\n";

                printMailStats($curFileIdx, $curFileName);
            }
        }   
    }
}


###################################################################
###################################################################
# Reformat the docs.versions.txt (output of infer-topics)
###################################################################
###################################################################
sub reformat {

    $saw   = 0;
    while (<INFILE>){
            if (/\//){ # New file
    
                # Print the previous file's data that we've been accumulating...
                if ($saw == 1){ 
                    if ($isCode){
                        foreach $i (@data){ printf CODEDATA "%.4f ", $i; }
                        print CODEDATA "\n";
                        printCodeStats($curFileIdx, $curFileName);
                    } else {
                        foreach $i (@data){ printf MAILDATA "%.4f ", $i; }
                        print MAILDATA "\n";
                        printMailStats($curFileIdx, $curFileName);
                    }
                }   

                # Save the curfile name for next time around
                @cols=split;
                $curFileIdx  = scalar($cols[0]); 
                $curFileName = $cols[1]; 

                $isCode=1;
                if ($doMail == 1){
                    if ($curFileName =~ /mailing_list/){
                        $isCode=0;
                    }
                }
   
            }   
            elsif (/etopic/){}    
            elsif(/\d/){ # Value for current file
                $saw = 1;
                @cols=split(/,/);
                $topic  = scalar($cols[0]);
                $weight = scalar($cols[1]); 
                $data[$topic] = $weight;
    
            }   
    }   
  
    #Finally, print the last line (not very graceful) 
    if ($isCode){
        foreach $i (@data){ printf CODEDATA "%.4f ", $i; }
        print CODEDATA "\n";

        printCodeStats($curFileIdx, $curFileName);
    } else {
        foreach $i (@data){ printf MAILDATA "%.4f ", $i; }
        print MAILDATA "\n";

        printMailStats($curFileIdx, $curFileName);
    }
                   
}



###############################################################
###############################################################
# Computes and outputs stats on code file
###############################################################
###############################################################
sub printBasicStats{
    my $fileID   = shift;
    my $fileName = shift;

    print CODEFILE "$fileID $fileName\n";
}


###############################################################
###############################################################
# Computes and outputs stats on code file
###############################################################
###############################################################
sub printCodeStats{
    my $fileID   = shift;
    my $fileName = shift;

    $type = "";
    if ($doCodeChangeType==1){
        $fileNameBak    = $fileName; # for wc
        $type           = $fileName;
        $type           = modify($fileName, \&getChangeType);
        $fileName       = modify($fileName, \&stripChangeType);
    }

    if ($doYs==1){
       $fileName =~ s/YYY/\//g; 
    }
    $full = $fileName;
    #print "$full\n";

    my($end, $dir) = fileparse($fileName);

    $end_noVersion = modify($end, \&stripVersion);

    $short = $end_noVersion;
    if ($doYs==1){
        $short =~ s!(.*YYY)([^YYY]+\.java)!$2!g;
    } else {
        $short =~ s!(.*\.)([^\.]+\.java)!$2!g;
    }

    $package = $end_noVersion;
    if ($doYs==1){
        $package =~ s/(.*YYY)([^YYY]+\.java)/$1/g;
    } else {
        $package =~ s/(.*\.)([^\.]+\.java)/$1/g;
    }
    $package =~ s/\.$//g;

    $version = "";
    $time    = "";
    $sloc    = "";   
    $churn   = ""; 
    $numWords= "";

    $version_str = "postgresql-08-03-05";
    if ($doTime==1){
        $version     = modify($end, \&getVersionNum);
        $version_str = modify($end, \&getVersionStr);

        #print ("$end, $version_str, $version\n");
    
        if (exists $hash{$version}){
            $time = $hash{$version};
        } else {
            print "$0: Warning: Could not find version \"$version\" in versionmap. Setting time to 0.\n";
            $time = 0;
        }
    }

   
    if ($doNumWords == 1){ 
        # numwords 
        $inputFileName = $fileNameBak;
        $inputFileName =~ s/\.\.\///g;
        $inputFileName = "$DATA/$inputFileName";
        $numWords = scalar(`wc -w $inputFileName | awk '{print \$1}'`);
        chomp $numWords;
    }
    
    if ($doAdvancedCodeStats ==1){ 
        $realfilename1 = $end_noVersion;
        $realfilename1 =~ s/(\.c$)/87U/g;
        $realfilename1 =~ s/\./\//g;
        $realfilename1 =~ s/87U/\.c/g;
        $realfilename1 =~ s/input.code.//g;
        $realfilename = "$BASE/$version_str/$realfilename1";

    
        # sloc 
        $sloc = 0;
        $sloc = scalar(`sloccount $realfilename | grep -A 1 "SLOC.*Dir" | tail -1 | awk '{print \$1}'`);
        chomp ($sloc);
    
        # churn
        #$realfilename1 =~ s/postgresql-..-..-...//g;
        $realfilename1 = modify($realfilename1, \&stripVersion);
        $cvsfile       = "$CVSREPO/$realfilename1,v";
        $go = 1;
        if (!-e  "$cvsfile"){ 
            $go = 0;
            $cvsfile =~ s/(.*)(\/.*,v)/$1\/Attic\/$2/g; 
            if (!-e  $cvsfile){ 
            } else {$go = 1;}
        } 
        if ($go = 1){
            $churn = `grep "date.*author" $cvsfile | wc -l`; 
            chomp ($churn);
        }
    }
   
    if ($doOnlyName==1){
        $out = modify($full, \&getOnlyName);
        print CODEFILE "$out\n";
    } else {
        print CODEFILE "$fileID $full $short $package $version $time $sloc $churn $numWords $type\n";
    }
    #print          "$fileID $full $short $package $version $time $sloc $churn $numWords\n";
}


###############################################################
###############################################################
# Computes and outputs stats on mailing thread
##############################################################
##############################################################
sub printMailStats{
    my $fileID   = shift;
    my $fileName = shift;

    if ($doAdvancedMailStats == 1){ 
        my($end, $dir) = fileparse($fileName);
        $t = $end;
        $t =~ s/.txt//g;
        print MAILFILE "$fileID $fileName $t $wc{$t} $num{$t} $start{$t} $end{$t} $dur{$t}\n";
    } else {
        print MAILFILE "$fileID $fileName\n";
    }
}


##############################################################
##############################################################
sub modify{
    my($text, $code) = @_;
    $code->($text);
    return $text;
}

