
source("scripts/makePlots.functions.R")
source("scripts/loadData.R")

out= "results/60/out"

###################################
###################################
# TAGS
###################################
###################################

pdf(sprintf("%s/figures/tag_growth.pdf", out), width=7, height=5)
par(mar=c(5.1, 5.1, 1.1, 1.1))
x = barplot(tags$Tags, ylab="New Tags Added", cex.axis=1.2, cex.lab=2.0, space=.5)

# Draw the time labels
atx = seq(1, length(tags$Month), by=2)
axis(side=1, at=x[atx], labels=format(tags$Month[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)
dev.off()


pdf(sprintf("%s/figures/tag_growth_cumulative.pdf", out), width=7, height=5)
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

dates = unique(posts$date)

type1 = c(posts[which(posts$type==1),]$count)
type2 = c(posts[which(posts$type==2),]$count)

df = rbind(type1/1000, type2/1000)
rownames(df) = c("Questions", "Answers")

pdf(sprintf("%s/post_growth.pdf", out), width=10, height=5)
    par(mar=c(5.1, 5.1, 1.1, 1.1))
    x = barplot(df, ylab="New Posts Added (K)", cex.axis=1.5, cex.lab=1.7, space=.5)

    # Draw the time labels
    atx = seq(1, length(dates), by=2)
    axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)
dev.off()



## Now do cumulative sums
df[1,] = cumsum(df[1,])
df[2,] = cumsum(df[2,])

pdf(sprintf("%s/post_growth_cum.pdf", out), width=10, height=5)
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

# Plot all the topics, one per plot

IDs =unique(impact$topic_id)

totalMax = max(impact$impact)
totalMin = min(impact$impact)

for (i in 1:length(IDs)){
    thisID = IDs[i]
    thisName = topicnames[which(topicnames$ID==thisID),]$Name


    a = impact[which(impact$topic_id==thisID),]

    x = 1:length(a$date)

    png(sprintf("%s/impact_%02d.png", out, thisID), width=640, height=480)
    par(mar=c(5.1, 5.1, 1.1, 1.1))
    plot(c(1, length(a$date)), c(min(a$impact), max(a$impact)), type="n", 
        cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Topic Impact")

    lines(x, a$impact, type="l", lwd=3.0, col="black", lty=1)

    atx = seq(1, length(a$date), by=2)
    axis(side=1, at=x[atx], labels=format(a$date[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

    title(sprintf("%s (id=%d)", thisName, thisID))
    dev.off()

    png(sprintf("%s/impact_scaled_%02d.png", out, thisID), width=640, height=480)
    par(mar=c(5.1, 5.1, 1.1, 1.1))
    plot(c(1, length(a$date)), c(totalMin, totalMax), type="n", 
        cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Topic Impact")

    lines(x, a$impact, type="l", lwd=3.0, col="black", lty=1)

    atx = seq(1, length(a$date), by=2)
    axis(side=1, at=x[atx], labels=format(a$date[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

    title(sprintf("%s (id=%d)", thisName, thisID))
    dev.off()
}



###################################
###################################
# TECH IMPACT
###################################
###################################

# Database platform
techsToPlot = list()
techsToPlot[[1]] = c(42, 7, "Oracle")
techsToPlot[[2]] = c(42, 8, "MySQL")
techsToPlot[[3]] = c(42, 9, "SQL Server")
techsToPlot[[4]] = c(42, 10, "SQLite")
techsToPlot[[5]] = c(42, 11, "PostgreSQL")

makeComparePlot(tech, techsToPlot, "topright", sprintf("%s/techimpact_databaseplatform.png", out))

# Version Control
techsToPlot = list()
techsToPlot[[1]] = c(33, 12, "Git")
techsToPlot[[2]] = c(33, 13, "SVN")

makeComparePlot(tech, techsToPlot, "topright", sprintf("%s/techimpact_versioncontrol.png", out))

# Mobile Apps
techsToPlot = list()
techsToPlot[[1]] = c(41, 14, "Android")
techsToPlot[[2]] = c(41, 15, "iPhone")
techsToPlot[[3]] = c(41, 16, "Blackberry")

makeComparePlot(tech, techsToPlot, "topleft", sprintf("%s/techimpact_mobileapp.png", out))

# Learning
techsToPlot = list()
techsToPlot[[1]] = c(35, 1, "C#")
techsToPlot[[2]] = c(35, 2, "C++")
techsToPlot[[3]] = c(35, 3, "Java")
techsToPlot[[4]] = c(35, 4, "Python")
techsToPlot[[5]] = c(35, 5, "PHP")
techsToPlot[[6]] = c(35, 6, "Javascript")

makeComparePlot(tech, techsToPlot, "topright", sprintf("%s/techimpact_learning", out))


# Scripting language
techsToPlot = list()
techsToPlot[[1]] = c(5, 18, "PHP")
techsToPlot[[2]] = c(5, 19, "Python")
techsToPlot[[3]] = c(5, 20, "Perl")
techsToPlot[[4]] = c(5, 21, "Javascript")
techsToPlot[[5]] = c(5, 22, "Bash")

makeComparePlot(tech, techsToPlot, "topright", sprintf("%s/techimpact_scriptinglanguage", out))

# Web
techsToPlot = list()
techsToPlot[[1]] = c(24, 23, "Javascript")
techsToPlot[[2]] = c(24, 24, "ASP.NET")
techsToPlot[[3]] = c(24, 25, "PHP")
techsToPlot[[4]] = c(24, 26, "JQuery")

makeComparePlot(tech, techsToPlot, "topleft", sprintf("%s/techimpact_web", out))

