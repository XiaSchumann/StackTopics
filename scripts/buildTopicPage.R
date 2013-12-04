
source("scripts/analyzeTrends.functions.R")
source("scripts/loadData.R")

outfile = "results/60/web/posts.html"
sink(file=outfile)


cat("<html>\n")
cat("<head>\n")
cat("  <link rel=\"stylesheet\" href=\"posts.css\">\n")
cat("</head>\n")


cat("<body>\n")

# Order by share
IDs = topicshare$ID

# First, build the table of contents
cat("<h1>Table of Contents</h1>\n")
cat("<i>Topics, sorted by their share metric:</i>\n")

cat("<ul>\n")
for (i in 1:length(IDs)){
    id = IDs[i]
    thisName = topicnames[which(topicnames$ID==id),]$Name
    topicshare_row = topicshare[which(topicshare$ID==id),]
    cat(sprintf("<li><a href=\"#%d\">", id))
    cat(sprintf("(%.2f) \"%s\" (Topic %d)</h3>\n", 100*topicshare_row$Share, thisName, id))
    cat("</a></li>")
}
cat("</ul>\n")
cat("<br/>\n")


cat("<h1>Topic Details</h1>\n")

for (i in 1:length(IDs)){
    id = IDs[i]

    thisName = topicnames[which(topicnames$ID==id),]$Name

    topicshare_row = topicshare[which(topicshare$ID==id),]
    topics_row = topics[which(topics$ID==id),]

    cat(sprintf("<a name=\"%d\"/>", id))
    cat("<table>\n")
    cat("<tr>\n")
    cat("<td colspan=\"100%\" valign=\"middle\" align=\"center\">\n")
    cat(sprintf("<h3>Topic %d: \"%s\"</h3>\n", id, thisName))
    cat("</td>\n")
    cat("</tr>\n")
    cat("<tr>\n")
    cat("<td valign=\"top\">\n")
    cat(sprintf("<h5>Metrics</h5>\n", id))
    cat(sprintf("Share: %.2f%%<br/>\n", 100*topicshare_row$Share))
    cat(sprintf("Posts: %s<br/>\n", format(topicshare_row$NumPosts, big.mark=",", scientific=F)))
    cat(sprintf("Q: %s (%.0f%%)<br/>\n", 
        format(topicshare_row$NumQ, big.mark=",", scientific=F), 
        100*topicshare_row$PerQ))
    cat(sprintf("A: %s (%.0f%%)<br/>\n", 
        format(topicshare_row$NumA, big.mark=",", scientific=F), 
        100*topicshare_row$PerA))

    a = impact[which(impact$topic_id==id),]$impact
    yy = cox.stuart.test(a)
    trend = steve.trend(yy)
    symbol = '--'
    if (trend == 1){
        symbol = '&uarr;'
    } else if (trend == -1){
        symbol = '&darr;'
    }

    cat(sprintf("Trend: %s<br/>\n", symbol))
    
    cat("</td>\n")


    cat("<td valign=\"top\">\n")
        cat(sprintf("<h5>Top Words</h5>\n", id))
        words = strsplit(topics_row$Words, " +")[[1]] 
        upper = min(16, length(words))
        for (j in 2:upper){
            cat(sprintf("%2d: %s<br/>\n", j-1, words[j]))
        }
    cat("</td>\n")

    cat("<td valign=\"top\">\n")
        cat(sprintf("<h5>Top Phrases</h5>\n", id))
        words = strsplit(topics_row$Phrases, ",")[[1]] 
        upper = min(25, length(words))
        for (j in 1:upper){
            cat(sprintf("%2d: %s<br/>\n", j, words[j]))
        }
    cat("</td>\n")

    
    topposts = read.table(sprintf("%s/%d.csv", file_toppostsdir, id), sep=",", header=F, stringsAsFactors=F)
    colnames(topposts) = c("PostID", "PostType", "Date", "TopicID", "Weight")
    cat("<td valign=\"top\">\n")
        cat(sprintf("<h5>Top Posts</h5>\n", id))
        words = strsplit(topics_row$Phrases, ",")[[1]] 
        upper = min(25, nrow(topposts))
        for (j in 1:upper){
            cat(sprintf("%2d: <a href=\"http://stackoverflow.com/questions/%d\">%d</a> (%.2f) <br/>\n", 
                    j,
                    topposts[j,]$PostID,
                    topposts[j,]$PostID,
                    topposts[j,]$Weight
            ))
        }
    cat("</td>\n")

    cat("<td valign=\"top\">\n")
        cat(sprintf("<h5>Top Tags (By TagScore)</h5>\n"))
        tags = tagscore[which(tagscore$TopicID==id),]
        tags = tags[order(-tags$AvgWeight),]
        upper = min(25, nrow(tags))
        for (j in 1:upper){
            cat(sprintf("%2d: %s (%s) (%.3f) <br/>\n", 
                    j,
                    tags[j,]$TagLabel,
                    format(tags[j,]$PostCount, big.mark=",", scientific=F),
                    tags[j,]$AvgWeight
            ))
        }
    cat("</td>\n")

    cat("<td valign=\"top\">\n")
        cat(sprintf("<h5>Top Tags (By Count)</h5>\n"))
        tags = tagscore[which(tagscore$TopicID==id),]
        tags = tags[order(-tags$PostCount),]
        upper = min(25, nrow(tags))
        for (j in 1:upper){
            cat(sprintf("%2d: %s (%s) (%.3f) <br/>\n", 
                    j,
                    tags[j,]$TagLabel,
                    format(tags[j,]$PostCount, big.mark=",", scientific=F),
                    tags[j,]$AvgWeight
            ))
        }
    cat("</td>\n")

    cat("<td valign=\"top\">\n")
        cat(sprintf("<h5>Impact (Own Scale)</h5>\n"))
        cat(sprintf("<img src=\"../out/impact_%02d.png\"/>\n", id))

    cat("</td>\n")

    cat("<td valign=\"top\">\n")
        cat(sprintf("<h5>Impact (Same scale)</h5>\n"))
        cat(sprintf("<img src=\"../out/impact_scaled_%02d.png\"/>\n", id))

    cat("</td>\n")

    cat("</tr>\n")
    cat("</table>\n")
    cat("<br/>\n")

}

cat("</body>\n")
cat("</html>\n")
sink()


