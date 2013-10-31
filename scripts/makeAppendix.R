

source("analyzeTrends.functions.R")

###############################################################
# First, create trend lines
###############################################################
trends = read.table('topic_trends.csv', sep=",", header=T, stringsAsFactors=F, check.names=F)
colsToPlot=4:ncol(trends)
for (i in 1:nrow(trends)){
    pdf(sprintf("test/figs/%02d.pdf", trends[i,1]), width=7, height=4)
    b = trends[i, colsToPlot]
    par(mar=c(0,0,0,0) + 0.1)
    x = range(1, length(b))
    y = range(b)
    x[1] = x[1] - .1
    x[2] = x[2] + .1
    y[1] = y[1] - max(y)*.1
    y[2] = y[2] + max(y)*.1
    plot(x, y, type="n", axes=FALSE, xlab="", ylab="")
    lines(as.numeric(b), type="l", lwd=20, col="black")
    par(mar=c(0,0,0,0))
    dev.off()
}


###############################################################
# Now output the share %
###############################################################
topics = read.table('topics.csv', sep=",", header=F, stringsAsFactors=F)

a = merge(topics, trends, by.x="V1", by.y="ID", sort=F)
colsToPlot=10:ncol(a)
a = a[, colsToPlot]

# escape certain characters:  _ ,#

topics$V2 = gsub("(#|_)", "\\\\\\1", topics$V2)
topics$V6 = gsub("(#|_)", "\\\\\\1", topics$V6)
topics$V7 = gsub("(#|_)", "\\\\\\1", topics$V7)

sink('tables/appendix1.tex')
for (i in 1:nrow(topics)){
    yy = cox.stuart.test(a[i,])
    trend = steve.trend(yy)
    symbol = '--'
    if (trend == 1){
        symbol = '$\\Uparrow$'
    } else if (trend == -1){
        symbol = '$\\Downarrow$'
    }
    
    cat(sprintf("\\topic{%s} & %.1f & %.1f & %.1f & %s & \\includegraphics[height=.45cm]{%02d.pdf} \\\\ \n", 
        topics[i,2], topics[i,3],topics[i,4],
        topics[i,5], symbol, topics[i,1]))
    if (i<nrow(topics)){ # dont output on last line
        cat(" \\hline \n")
    }
}
sink()

sink('tables/appendix2.tex')
for (i in 1:nrow(topics)){
    cat(sprintf("\\topic{%s} & {\\em \\footnotesize %s} \\\\ \n", 
        topics[i,2], topics[i,6]))
    if (i<nrow(topics)){ # dont output on last line
        cat(" \\hline \n")
    }
}
sink()

sink('tables/appendix3.tex')
for (i in 1:nrow(topics)){
    cat(sprintf("\\topic{%s} & {\\footnotesize ", topics[i,2])) 
    # only take the first 7 tags, and surround each with {\tt }
    cat(sprintf("%s", strsplit(topics[i,7], " ")[[1]][1:7]))
    cat("} \\\\ \n") 
    if (i<nrow(topics)){ # dont output on last line
        cat(" \\hline \n")
    }
}
sink()
