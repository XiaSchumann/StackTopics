

base="../SO/Sep2013"
out= "results/60/out"

tags = read.table(sprintf("%s/tagdates.csv", base), sep="|", header=F, stringsAsFactors=F)
colnames(tags) = c("TopicID", "TagID", "Date")

tagID=0
dates = sort(unique(tags$Date)) 

counts(tags, 0, dates)
counts(tags, 5096, dates)




