

#args <- commandArgs(trailingOnly = TRUE)
#file_topicshare <- args[1]
#file_topics <- args[2]
#file_tagscore <- args[3]
#file_impact <- args[4]
#file_toppostsdir <- args[5]


file_topicshare="results/60/analysis/topicshare.csv"
file_topics = "results/60/topics.csv"
file_toppostsdir = "results/60/analysis/topposts"
file_tagscore = "results/60/analysis/tagscore.csv"

###################################
###################################
# TAGS
###################################
###################################

topicshare = read.table(file_topicshare, sep=",", header=F, stringsAsFactors=F)
colnames(topicshare) = c("ID", "NumPosts", "Share", "NumQ", "NumA")
topicshare = cbind(topicshare, topicshare$NumQ/topicshare$NumPosts, topicshare$NumA/topicshare$NumPosts)
colnames(topicshare) = c("ID", "NumPosts", "Share", "NumQ", "NumA", "PerQ", "PerA")

topics = read.table(file_topics, sep="|", header=F, stringsAsFactors=F)
colnames(topics) = c("ID", "Val", "Vocab", "Words", "Phrases")

tagscore = read.table(file_tagscore, sep=",", header=F, stringsAsFactors=F)
colnames(tagscore) = c("TopicID", "TagLabel", "TagID", "PostCount", "SumWeight", "AvgWeight")

sink(file="output.html")

cat("<html>\n")
cat("<head></head>\n")
cat("<body>\n")
cat("<table border=1>\n")

for (id in unique(topics$ID)){


    topicshare_row = topicshare[which(topicshare$ID==id),]
    topics_row = topics[which(topics$ID==id),]

    cat("<tr>\n")
    cat("<td valign=\"top\">\n")
    cat(sprintf("<h3>Topic %d</h3>\n", id))
    cat(sprintf("Share: %.2f%%<br/>\n", 100*topicshare_row$Share))
    cat(sprintf("Posts: %s<br/>\n", format(topicshare_row$NumPosts, big.mark=",", scientific=F)))
    cat(sprintf("Q: %s (%.0f%%)<br/>\n", 
        format(topicshare_row$NumQ, big.mark=",", scientific=F), 
        100*topicshare_row$PerQ))
    cat(sprintf("A: %s (%.0f%%)<br/>\n", 
        format(topicshare_row$NumA, big.mark=",", scientific=F), 
        100*topicshare_row$PerA))
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
        for (j in 2:upper){
            cat(sprintf("%2d: %s<br/>\n", j-1, words[j]))
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
        cat(sprintf("<h5>Top Tags</h5>\n"))
        tags = tagscore[which(tagscore$TopicID==id),]
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
        cat(sprintf("<h5>Impact</h5>\n"))
        cat(sprintf("<img src=\"results/60/out/impact_%02d.png\"/>\n", id))

    cat("</td>\n")

    cat("</tr>\n")

}

cat("</table>\n")
cat("</body>\n")
cat("</html>\n")
sink()
