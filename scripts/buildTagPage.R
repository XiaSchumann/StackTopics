
source("scripts/analyzeTrends.functions.R")
source("scripts/loadData.R")

outfile = "results/60/web/tags.html"
sink(file=outfile)


cat("<html>\n")
cat("<head>\n")
cat("  <link rel=\"stylesheet\" href=\"posts.css\">\n")
cat("</head>\n")


cat("<body>\n")

# Order by share
IDs = topicshare$ID

# First, build the table of contents
#cat("<h1>Table of Contents</h1>\n")
#cat("<i>Topics, sorted by their share metric:</i>\n")



cat("<h1>Tag Details</h1>\n")

tagLabels = unique(tagscore$TagLabel)

cat("<table>\n")
for (i in 1:length(tagLabels)){
    label = tagLabels[i]

    if (label == "telerik"){


    a = tagscore[which(tagscore$TagLabel==label),]
    a = a[order(-a$AvgWeight),]
    cat("<tr>\n")
    cat("<td colspan=\"100%\">\n")
    cat(sprintf("Tag: \"%s\"\n", label))
    cat("</td>\n")
    cat("</tr>\n")

    cat("<tr>\n")
    cat("<td><h5>Topic Name</h5></td>\n")
    cat("<td><h5>Post Count</h5></td>\n")
    cat("<td><h5>Sum Weight</h5></td>\n")
    cat("<td><h5>Avg Weight</h5></td>\n")
    cat("</tr>\n")

    upper = min(15, nrow(a))
    for (i in 1:upper){

        thisName = topicnames[which(topicnames$ID==a[i,]$TopicID),]$Name

        cat("<tr>\n")

        cat("<td>\n")
        cat(sprintf("\"%s\" (Topic %d)\n", thisName, a[i,]$TopicID))
        cat("</td>\n")

        cat("<td>\n")
        cat(sprintf("%d\n", a[i,]$PostCount))
        cat("</td>\n")

        cat("<td>\n")
        cat(sprintf("%.1f\n", a[i,]$SumWeight))
        cat("</td>\n")

        cat("<td>\n")
        cat(sprintf("%.3f\n", a[i,]$AvgWeight))
        cat("</td>\n")


        cat("</tr>\n")
    }
    }
}
cat("<table>\n")
        
    

cat("</body>\n")
cat("</html>\n")
sink()


