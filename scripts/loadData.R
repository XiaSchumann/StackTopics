base="results/60/analysis"
out= "results/60/out"

file_topicshare="results/60/analysis/topicshare.csv"
file_topics = "results/60/topics.csv"
file_toppostsdir = "results/60/analysis/topposts"
file_tagscore = "results/60/analysis/tagscore.csv"

topicshare = read.table(file_topicshare, sep=",", header=F, stringsAsFactors=F)
colnames(topicshare) = c("ID", "NumPosts", "Share", "NumQ", "NumA")
topicshare = cbind(topicshare, topicshare$NumQ/topicshare$NumPosts, topicshare$NumA/topicshare$NumPosts)
colnames(topicshare) = c("ID", "NumPosts", "Share", "NumQ", "NumA", "PerQ", "PerA")

topics = read.table(file_topics, sep="|", header=F, stringsAsFactors=F)
colnames(topics) = c("ID", "Val", "Vocab", "Words", "Phrases")

tagscore = read.table(file_tagscore, sep=",", header=F, stringsAsFactors=F)
colnames(tagscore) = c("TopicID", "TagLabel", "TagID", "PostCount", "SumWeight", "AvgWeight")

tags = read.table(sprintf("%s/newtagcountbymonth.csv", base), sep=",", header=F, stringsAsFactors=F)
colnames(tags) = c("Tags", "Year", "Month")

tags$Cum = cumsum(tags$Tags)

tags$Date = sprintf("%d-%02d-01", tags$Year, tags$Month)
tags$Date = strptime(tags$Date, format="%Y-%m-%d")

posts = read.table(sprintf("%s/numpostsbymonth.csv", base), sep=",", header=F, stringsAsFactors=F)
colnames(posts) = c("count", "date", "type")
posts$date = strptime(posts$date, format="%Y-%m-%d")

topicnames = read.table(sprintf("%s/topicnames.csv", base), sep=",", header=F, stringsAsFactors=F, check.names=F)
colnames(topicnames) = c("ID", "Name")

impact = read.table(sprintf("%s/topicimpactbymonth.csv", base), sep=",", header=F, stringsAsFactors=F, check.names=F)
# Get rid of metric ID column
impact = impact[,-2]
colnames(impact) = c("topic_id", "date", "impact")
# Get rid of first month, so small
impact = impact[-which(impact$date=="2008-07-31"),]
impact$date = strptime(impact$date, format="%Y-%m-%d")


tech = read.table(sprintf("%s/techimpact.csv", base), sep=",", header=F, stringsAsFactors=F, check.names=F)
colnames(tech) = c("TechID","TopicID","Year", "Month","PostCount","SumWeight","MonthWeight","AvgWeight")
tech$Date = sprintf("%s-%s-%s", tech$Year, tech$Month, 1)
tech$Date = strptime(tech$Date, format="%Y-%m-%d")
tech = tech[-which(as.character(tech$Date)=="2008-08-01"),]
tech = tech[-which(as.character(tech$Date)=="2013-09-01"),]


