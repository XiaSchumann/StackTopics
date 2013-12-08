
###################################
###################################
# TECH IMPACT
###################################
###################################


cols=c("black", "black", "black", "grey", "grey", "grey")
ltys=c(1, 2, 3, 1, 2, 3)

makeComparePlot = function(tech, techsToPlot, legendLocation, fileName){

png(fileName,  width=640, height=480)

    numbers = list()
    for (i in 1:length(techsToPlot)){
        thisTopicID = as.numeric(techsToPlot[[i]][1])
        thisTechID  = as.numeric(techsToPlot[[i]][2])
        numbers[[i]] = tech[tech$TechID==thisTechID & tech$TopicID==thisTopicID,]$AvgWeight
        dates = tech[tech$TechID==thisTechID & tech$TopicID==thisTopicID,]$Date
    }

    numbers = do.call(cbind, numbers)
    myMax = max(numbers)
    x = seq(1, length(dates))

    par(mar=c(5.1, 5.1, 1.1, 1.1))
    
    plot(c(0,length(x)), c(0, myMax), type="n", 
        cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Technical Impact")

    for (i in 1:ncol(numbers)){
        lines(x, numbers[,i], type="l", lwd=3.0, col=cols[i], lty=ltys[i])
    }
    
    atx = seq(1, length(dates), by=2)
    axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)


    # Manually draw the labels
    names = c()
    for (i in 1:length(techsToPlot)){
        thisText = techsToPlot[[i]][3]
        #thisX = as.numeric(techsToPlot[[i]][4])
        #thisY = as.numeric(techsToPlot[[i]][5])
        #text(thisX, thisY, thisText, cex=1.5)
        names[i] = thisText
    }
    legend(legendLocation, legend=names, col=cols, lty=ltys, lwd=3)

    
dev.off()
}

