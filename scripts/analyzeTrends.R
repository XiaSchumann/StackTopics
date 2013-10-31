
library("plotrix")
source("analyzeTrends.functions.R")

trends = read.table('topic_trends.csv', sep=",", header=T, stringsAsFactors=F, check.names=F)

a = trends[,4:ncol(trends)]



# build a dataframe with trend statistics of each row
N = nrow(trends)
df = data.frame(ID=rep(NA,N), Label=rep("",N), Trend=rep(NA,N), p=rep(NA,N),
        min=rep(NA,N), minMonth=rep(NA,N), max=rep(NA,N), maxMonth=rep(NA,N),
        perChange=rep(NA,N), actChange=rep(NA,N), maxChange=rep(NA,N),
        maxChangeMonth=rep(NA,N),
        stringsAsFactors=F)
for (i in 1:N){
    x = as.numeric(a[i,])
    yy = cox.stuart.test(x)
    trend = steve.trend(yy)
    size = yy$statistic
    df[i,1] = trends[i,1]
    df[i,2] = trends[i,2]
    df[i,3:4] = c(trend,yy$statistic)
    act = (x[length(x)] - x[1])
    per = 100* (act / x[1])
    changes = x[2:length(x)] - x[1:(length(x)-1)]
    maxChange = max(changes)
    maxChangeM = which.max(changes)
    minM = which.min(x)
    maxM = which.max(x)
    df[i,5:12] = c( min(x), minM, max(x), maxM, per, act, maxChange, maxChangeM)
}


# Cool matrix plot!

testx=t(a)
stackpoly(testx,main="Test Stackpoly II", ,border="black", staxx=TRUE,stack=TRUE)


    
# Plot the trends? 
dates = sprintf("%s-01", colnames(trends)[4:ncol(trends)]) 
dates = strptime(dates, format="%Y-%m-%d")

cols=c("black", "black", "black", "grey", "grey", "grey")
ltys=c(1, 2, 4, 1, 2, 4)

#Top 5 biggest gainers, by percentage
rowsToPlot = sort(df$perChange, decreasing=T, index.return=T)$ix[1:5]

pdf("../latex_revision/paper/figures/trends_increasing.pdf", width=7, height=5)
par(mar=c(5.1, 5.1, 1.1, 1.1))

x=1:length(dates)
plot(c(min(x), max(x)+11), c(min(a[rowsToPlot,]), max(a[rowsToPlot, ])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Topic Impact")

for (i in 1:length(rowsToPlot)){
    lines(x, a[rowsToPlot[i], ], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

text(26, 2.95, "Tabular Data",   cex=1.5, pos=4)
text(26, 3.50, "Mobile Apps",    cex=1.5, pos=4)
text(26, 3.25, "Image/Display",  cex=1.5, pos=4)
text(26, 2.82, "Web Devel.",     cex=1.5, pos=4)
text(26, 3.1,  "Error Handling", cex=1.5, pos=4)
dev.off()


#Top 5 biggest losers, by percentage
rowsToPlot = sort(df$perChange, index.return=T)$ix[1:5]

pdf("../latex_revision/paper/figures/trends_decreasing.pdf", width=7, height=5)
par(mar=c(5.1, 5.1, 1.1, 1.1))

x=1:length(dates)
plot(c(min(x)-11, max(x)), c(min(a[rowsToPlot,]), max(a[rowsToPlot, ])), type="n", 
       cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Topic Impact")

for (i in 1:length(rowsToPlot)){
    lines(x, a[rowsToPlot[i], ], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
}

atx = seq(1, length(dates), by=2)
axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

text(-12, 7.15, "Job/Experience",   cex=1.5, pos=4)
text(-12, 4.3, "Learning/Books",    cex=1.5, pos=4)
text(-11.5, 1.75, "Version Control",  cex=1.5, pos=4)
text(-9.5, 3.8, "Project/OSS",     cex=1.5, pos=4)
text(-4.1,  3.3,  ".NET", cex=1.5, pos=4)
dev.off()




idx = which(df$Trend==0)
matplot(t(a[idx,]), type="l", lwd=2, col=c("grey1", "grey25", "grey50"))

idx = which(df$Trend==-1)
matplot(t(a[idx,]), type="l", lwd=2, col=c("grey1", "grey25", "grey50"))



# Now, summarize and sort and summarize again!    
table(df$Trend)

# Increasing trends, sorted by percentage change:

# Increasing trends, sorted by actual change:

# Decreasing trends, sorted by percentage change:

# Increasing trends, sorted by actual change:

# Biggest single change:
    


