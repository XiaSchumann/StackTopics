
base="../results/60"

###################################
###################################
# TAGS
###################################
###################################

# TODO
tags = read.table(sprintf("%s/newtagcount.csv", base), sep=",", header=F, stringsAsFactors=F)
colnames(tags) = c("Tags", "Year", "Month")


tags$Date = sprintf("%d-%02d-01", tags$Year, tags$Month)
tags$Cum = cumsum(tags$Tags)


# Format the date
tags$Date = strptime(tags$Date, format="%Y-%m-%d")


pdf(sprintf("%s/figures/tag_growth.pdf", base), width=7, height=5)
par(mar=c(5.1, 5.1, 1.1, 1.1))
x = barplot(tags$Tags, ylab="New Tags Added", cex.axis=1.2, cex.lab=2.0, space=.5)

# Draw the time labels
atx = seq(1, length(tags$Month), by=2)
axis(side=1, at=x[atx], labels=format(tags$Month[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)
dev.off()


pdf(sprintf("%s/figures/tag_growth_cumulative.pdf", base), width=7, height=5)
par(mar=c(5.1, 5.1, 1.1, 1.1))
x = 1:length(tags$Cum)
plot(x, tags$Cum/1000, type="l", lwd=5.0, xlab="", ylab="Total Tags (K)", xaxt="n", cex.axis=1.2, cex.lab=2.0)

# Draw the time labels
atx = seq(1, length(tags$Month), by=2)
axis(side=1, at=x[atx], labels=format(tags$Month[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)
dev.off()



###################################
###################################
# NUMBER OF POSTS BY TYPE AND MONTH
###################################
###################################

posts = read.table(sprintf("%s/numpostsbymonth.csv", base), sep=",", header=F, stringsAsFactors=F)

colnames(posts) = c("count", "date", "type")

posts = posts[-which(posts$type==3),]
posts = posts[-which(posts$type==4),]
posts = posts[-which(posts$type==5),]
posts = posts[-which(posts$type==6),]
posts = posts[-which(posts$type==7),]
posts = posts[-which(posts$type==8),]

posts$date = strptime(posts$date, format="%Y-%m-%d")

dates = unique(posts$date)

type1 = c(posts[which(posts$type==1),]$count)
type2 = c(posts[which(posts$type==2),]$count)

df = rbind(type1/1000, type2/1000)
rownames(df) = c("Questions", "Answers")


pdf("./out/post_growth.pdf", width=10, height=5)
    par(mar=c(5.1, 5.1, 1.1, 1.1))
    x = barplot(df, ylab="New Posts Added (K)", cex.axis=1.5, cex.lab=1.7, space=.5)

    # Draw the time labels
    atx = seq(1, length(dates), by=2)
    axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)
dev.off()



## Now do cumulative sums
df[1,] = cumsum(df[1,])
df[2,] = cumsum(df[2,])

pdf("./out/post_growth_cum.pdf", width=10, height=5)
    par(mar=c(5.1, 5.1, 1.1, 1.1))
    plot(c(1, length(dates)), c(min(df[1,]), max(df[2,])), type="n", 
        cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Cumulative Posts (K)")

    lines(seq(1, length(dates), 1), df[1,], type="l", lwd=3.0, col="black", lty=1)
    lines(seq(1, length(dates), 1), df[2,], type="l", lwd=3.0, col="black", lty=2)

    # Draw the time labels
    atx = seq(1, length(dates), by=2)
    axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)
dev.off()


###################################
###################################
# TOPIC IMPACT
###################################
###################################
impact = read.table(sprintf("%s/topicimpactbymonth.csv", base), sep=",", header=F, stringsAsFactors=F, check.names=F)
topicnames = read.table(sprintf("%s/topicnames.csv", base), sep=",", header=F, stringsAsFactors=F, check.names=F)


# Get rid of metric ID column
impact = impact[,-2]
colnames(impact) = c("topic_id", "date", "impact")
impact$date = strptime(impact$date, format="%Y-%m-%d")


# Plot all the topics, one per plot

IDs = unique(impact$topic_id)

for (i in 1:length(IDs)){
    thisID = IDs[i]
    thisName = topicnames[i,2]

    a = impact[which(impact$topic_id==thisID),]

    x = 1:length(a$date)

    pdf(sprintf("./out/impact_%02d.pdf", thisID), width=7, height=5)
    par(mar=c(5.1, 5.1, 1.1, 1.1))
    plot(c(1, length(a$date)), c(min(a$impact), max(a$impact)), type="n", 
        cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Topic Impact")

    lines(x, a$impact, type="l", lwd=3.0, col="black", lty=1)

    atx = seq(1, length(a$date), by=2)
    axis(side=1, at=x[atx], labels=format(a$date[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

    title(sprintf("%s (id=%d)", thisName, thisID))
    dev.off()
}



# TODO: below


cols=c("black", "black", "black", "grey", "grey", "grey")
ltys=c(1, 2, 4, 1, 2, 4)


###################################
pdf("../latex_revision/paper/figures/trends_devplatform.pdf", width=7, height=5)
rowsToPlot = c(20, 33, 29)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(trends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Topic Impact")

for (i in 1:length(rowsToPlot)){
    lines(x, trends[rowsToPlot[i], colsToPlot], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels
text( 5, 2.05, "Java", cex=1.5)
text(13.3, 2.4, ".NET", cex=1.5)
text(20, 2.85, "Visual Studio", cex=1.5)

dev.off()


###################################
pdf("../latex_revision/paper/figures/trends_depplatform.pdf", width=7, height=5)
rowsToPlot = c(4, 11, 16)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(trends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Topic Impact")

for (i in 1:length(rowsToPlot)){
    lines(x, trends[rowsToPlot[i], colsToPlot], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels

text(18.8, 3.3, "Mobile Apps", cex=1.5)
text(5.8, 2.8, "Web\nDevelopment", cex=1.5)
text(22, 2.1, "CSS/Web\nDesign", cex=1.5)

dev.off()



###################################
###################################
ftrends = read.table('focused_trends.csv', sep=",", header=T, stringsAsFactors=F, check.names=F)

cols=c("black", "black", "black", "grey", "grey", "grey")
ltys=c(1, 2, 4, 1, 2, 4)

rowsToPlot = (1:nrow(ftrends))
dates = ftrends$Month[rowsToPlot]
dates = sprintf("%s-01", dates) 
dates = strptime(dates, format="%Y-%m-%d")

x = 1:length(rowsToPlot)


###################################
pdf("../latex_revision/paper/figures/ftrends_database.pdf", width=7, height=5)
colsToPlot = c(22,21,20, 23,24)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(ftrends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Technical Impact")

for (i in 1:length(colsToPlot)){
    lines(x, ftrends[rowsToPlot, colsToPlot[i]], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels
text(20, 10.6, "SQL Server", cex=1.5)
text(23,    8, "MySQL", cex=1.5)
text(23, 2.8, "Oracle", cex=1.5)
text(17, 1.5, "SQLite", cex=1.5)
text(23, 0.5, "PostgreSQL", cex=1.5)

dev.off()


###################################
pdf("../latex_revision/paper/figures/ftrends_mobile.pdf", width=7, height=5)
colsToPlot = c(15, 14, 16)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(ftrends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Technical Impact")

for (i in 1:length(colsToPlot)){
    lines(x, ftrends[rowsToPlot, colsToPlot[i]], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels
text(20, 20.6, "iPhone", cex=1.5)
text(18,   11, "Android", cex=1.5)
text(23, 1.8, "Blackberry", cex=1.5)

dev.off()


###################################
pdf("../final_revision_paper/figures/ftrends_vcs.pdf", width=7, height=5)
colsToPlot = c(18,19)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(ftrends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Technical Impact")

for (i in 1:length(colsToPlot)){
    lines(x, ftrends[rowsToPlot, colsToPlot[i]], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels
text(25.3,  9.5, "SVN", cex=1.5)
text(21.8,   12, "Git", cex=1.5)

dev.off()


###################################
pdf("../latex_revision/paper/figures/ftrends_learning.pdf", width=7, height=5)
colsToPlot = c(25,26,27,28,29,30)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(ftrends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Technical Impact")

for (i in 1:length(colsToPlot)){
    lines(x, ftrends[rowsToPlot, colsToPlot[i]], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels
text(20,    5, "C/C++", cex=1.5)
text(13,  2.8, "C#", cex=1.5)
text(18.8,  2.1, "Java", cex=1.5)
text(23,  1.8, "Python", cex=1.5)
text(17.5,  0.7, "PHP", cex=1.5)
text(23,  0.4, "JavaScript", cex=1.5)

dev.off()


###################################
pdf("../latex_revision/paper/figures/ftrends_scripting.pdf", width=7, height=5)
colsToPlot = c(9,10,11,12)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(ftrends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Technical Impact")

for (i in 1:length(colsToPlot)){
    lines(x, ftrends[rowsToPlot, colsToPlot[i]], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels
text(19.5, 11.5, "PHP", cex=1.5)
text(23,  9.1, "Python", cex=1.5)
text(6,    2.7, "Perl", cex=1.5)
text(6,    0.2, "JavaScript", cex=1.5)

dev.off()


###################################
pdf("../latex_revision/paper/figures/ftrends_web.pdf", width=7, height=5)
colsToPlot = c(4,5,6,7)
par(mar=c(5.1, 5.1, 1.1, 1.1))
plot(range(x), c(0, max(ftrends[rowsToPlot, colsToPlot])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Technical Impact")

for (i in 1:length(colsToPlot)){
    lines(x, ftrends[rowsToPlot, colsToPlot[i]], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

# Manually draw the labels
text(23,    15.5, "JQuery", cex=1.5)
text(23,    11.5, "JavaScript", cex=1.5)
text(23,     6.2, "ASP.NET", cex=1.5)
text(7,     1.0, "PHP", cex=1.5)

dev.off()


