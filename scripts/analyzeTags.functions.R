
cols=c("black", "black", "black", "grey", "grey", "grey", "blue", "blue", "blue", "red", "red", "red")
ltys=c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3)

counts = function(tags, tagGroup, tagLabel, dates){

    tagID = tagnames[which(tagnames$TagLabel==tagLabel),]$TagID

    a = data.frame(
                TagGroup=rep(NA, length(dates)),
                TagLabel=rep(NA, length(dates)),
                TagID=rep(-1, length(dates)),
                Date=rep(NA, length(dates)),
                Count=rep(0, length(dates))
                )
    tmp = tags[tags$TagID==tagID,]$Date
    for( i in 1:length(dates)){
        num = sum(tmp==dates[i])
        a[i,] = c(tagGroup, tagLabel, tagID, dates[i], num)
    }
    a
}

aggGroups = function(tagcounts, dates){

    groups = unique(tagcounts$TagGroup)

    for (i in 1:length(groups)){
        thisGroup = groups[i]

        tmp = tagcounts[tagcounts$TagGroup==thisGroup,]
    
        utags = unique(tmp$TagLabel)

        # Do the first one
        a = tmp[tmp$TagLabel==utags[1],]

        if (length(utags) > 1){
            for (j in 2:length(utags) ){
                thisTagLabel = utags[j]
                a$Count = a$Count + tmp[tmp$TagLabel==utags[j],]$Count
            }
        }

        a$TagLabel = rep(sprintf("%s-group", thisGroup), nrow(a))
    
        if (i == 1){
            b = a
        } else {
            b = rbind(b, a)
        }
    }
    b
}

aggGroups2 = function(groupName, dates, companyList, tagList ){

    tmp = tags[tags$TagID %in% companyList,]
    tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% tagList),]

    a = data.frame(
                TagGroup=rep(groupName, length(dates)),
                TagLabel=rep(groupName, length(dates)),
                TagID=rep(-1, length(dates)),
                Date=rep(NA, length(dates)),
                Count=rep(0, length(dates))
                )
    tmp = tmp$Date
    for( i in 1:length(dates)){
        num = sum(tmp==dates[i])
        a[i,4:5] = c(dates[i], num)
    }
    a
}

            
makeTagPlots = function(tagcounts, dates, out){

    labels = unique(tagcounts$TagLabel)
    dates = strptime(dates, format="%Y-%m-%d")

    for (i in 1:length(labels)){
        thisLabel = labels[i]

        tmp = tagcounts[tagcounts$TagLabel==thisLabel,]
        tmp = tmp[1:length(dates),]

        x = 1:length(dates)
        y = as.numeric(tmp$Count)
      
        png(sprintf("%s/tags_%s.png", out, thisLabel), width=640, height=480)
            par(mar=c(5.1, 5.1, 1.1, 1.1))
            plot(c(1, length(x)), c(min(y), max(y)), type="n", 
            cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Tag Count")

            lines(x, y, type="l", lwd=3.0, col="black", lty=1)

            atx = seq(1, length(dates), by=2)
            axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

            title(sprintf("\"%s\"", thisLabel ))
        dev.off()
    }
}
            
makeComparisonPlot = function(tagcounts, dates, file, title, labels){

    dates = strptime(dates, format="%Y-%m-%d")

    # First, find out max
    maxY = 0
    for (i in 1:length(labels)){
        thisLabel = labels[i]
        tmp = tagcounts[tagcounts$TagLabel==thisLabel,]
        tmp = tmp[1:length(dates),]
        maxY = max(maxY, as.numeric(tmp$Count))
    }

    x = 1:length(dates)

    png(file, width=640, height=480)
        par(mar=c(5.1, 5.1, 1.1, 1.1))
        plot(c(1, length(x)), c(0, maxY), type="n", 
        cex.axis=1.2, cex.lab=2.0, xlab="", xaxt="n", ylab="Tag Count")

        for (i in 1:length(labels)){
            thisLabel = labels[i]

            tmp = tagcounts[tagcounts$TagLabel==thisLabel,]
            tmp = tmp[1:length(dates),]

            x = 1:length(dates)
            y = as.numeric(tmp$Count)
      
            lines(x, y, type="l", lwd=3.0, col=cols[i], lty=ltys[i])

        }

        atx = seq(1, length(dates), by=2)
        axis(side=1, at=x[atx], labels=format(dates[atx], "%b\n%Y"), padj=0.5, cex.axis=1.2)

        legend("topleft", legend=labels, col=cols, lty=ltys, lwd=3)

        title(sprintf("\"%s\"", title ))
    dev.off()
}


printTagLabels = function(all){
    for (i in 1:length(all)){ 
        thisID = all[i];
        thisLabel = tagnames[which(tagnames$TagID==thisID),]$TagLabel
        cat(sprintf("[%s], ", thisLabel ))
    }
    cat("\n")
}
