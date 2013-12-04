
counts = function(tags, tagID, dates){

    a = data.frame(tagID=rep(NA, length(dates)),
                date=rep(NA, length(dates)),
                count=rep(0, length(dates))
                )
    tmp = tags[tags$TagID==tagID,]$Date
    for( i in 1:length(dates)){
        num = sum(tmp==dates[i])
        a[i,] = c(tagID, dates[i], num)
    }
    a
}
