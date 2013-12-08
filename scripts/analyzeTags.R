


source("scripts/loadData.R")
source("scripts/analyzeTags.functions.R")
base="results/60/analysis"
out= "results/60/out"

tags = read.table(sprintf("%s/tagdates.csv", base), sep="|", header=F, stringsAsFactors=F)
colnames(tags) = c("TopicID", "TagID", "Date")

dates = sort(unique(tags$Date)) 
# Remove first and last months, since they're not complete
dates = dates[-1]
dates = dates[-length(dates)]

tagcounts = counts(tags, "telerik", "telerik", dates)
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-ajax", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-charting", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-combobox", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-diagram", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-editor", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-grid", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-javascript", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-mvc", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-open-access", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-radformdecorator", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-radinput", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-radlistbox", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-radmaskedtextbox", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-radribbonbar", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-reporting", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-scheduler", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-test-studio", dates))
tagcounts = rbind(tagcounts, counts(tags, "telerik", "telerik-window", dates))

tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-asp.net-mvc", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-autocomplete", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-combobox", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-grid", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-menu", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-mobile", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-mvvm", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-scheduler", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-treeview", dates))
tagcounts = rbind(tagcounts, counts(tags, "kendo", "kendo-ui", dates))

tagcounts = rbind(tagcounts, counts(tags, "rad", "rad", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "rad-controls", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "rad-studio", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "rad-studio-2007", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "rad-studio-2009", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "rad-studio-2010", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "rad-studio-xe4", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "radajaxloadingpanel", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "radajaxmanager", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "radchart", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "radcombobox", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "raddatepicker", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "raddatapager", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "raddiagram", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "raddocking", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "radeditor", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "radgrid", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "radgridview", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "telerik-radformdecorator", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "telerik-radinput", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "telerik-radlistbox", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "telerik-radmaskedtextbox", dates))
tagcounts = rbind(tagcounts, counts(tags, "rad", "telerik-radribbonbar", dates))

tagcounts = rbind(tagcounts, counts(tags, "just", "justcode", dates))
tagcounts = rbind(tagcounts, counts(tags, "just", "justmock", dates))

tagcounts = rbind(tagcounts, counts(tags, "sitefinity", "sitefinity", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitefinity", "sitefinity-3x", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitefinity", "sitefinity-4", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitefinity", "sitefinity-5", dates))

tagcounts = rbind(tagcounts, counts(tags, "icenium", "icenium", dates))

tagcounts = rbind(tagcounts, counts(tags, "eqatec", "eqatec", dates))


tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin-ios", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin-studio", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin.android", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin.auth", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin.ios", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin.mac", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin.mobile", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamarin.social", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamdatagrid", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamdatatree", dates))
tagcounts = rbind(tagcounts, counts(tags, "xamarin", "xamgrid", dates))


tagcounts = rbind(tagcounts, counts(tags, "appcelerator", "appcelerator", dates))
tagcounts = rbind(tagcounts, counts(tags, "appcelerator", "appcelerator-mobile", dates))

tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-2", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-architect", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-charts", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-cmd", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-command", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-touch", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-touch-2", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-touch-2-proxy", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-touch-2.1", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-touch-2.2", dates))
tagcounts = rbind(tagcounts, counts(tags, "sencha", "sencha-touch-theming", dates))

tagcounts = rbind(tagcounts, counts(tags, "devexpress", "devexpress", dates))
tagcounts = rbind(tagcounts, counts(tags, "devexpress", "devexpress-windows-ui", dates))

tagcounts = rbind(tagcounts, counts(tags, "jetbrains", "jetbrains", dates))

tagcounts = rbind(tagcounts, counts(tags, "redgate", "redgate", dates))

tagcounts = rbind(tagcounts, counts(tags, "infragistics", "infragistics", dates))

tagcounts = rbind(tagcounts, counts(tags, "componentone", "componentone", dates))

tagcounts = rbind(tagcounts, counts(tags, "componentart", "componentart", dates))

tagcounts = rbind(tagcounts, counts(tags, "syncfusion", "syncfusion", dates))

tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore-dms", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore-ecm", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore-media-library", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore-mvc", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore-oms", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore-workflow", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore5.2", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore6", dates))
tagcounts = rbind(tagcounts, counts(tags, "sitecore", "sitecore7", dates))


tagcounts = rbind(tagcounts, counts(tags, "atlassian", "atlassian", dates))
tagcounts = rbind(tagcounts, counts(tags, "atlassian", "atlassian-crowd", dates))
tagcounts = rbind(tagcounts, counts(tags, "atlassian", "atlassian-crucible", dates))
tagcounts = rbind(tagcounts, counts(tags, "atlassian", "atlassian-fisheye", dates))
tagcounts = rbind(tagcounts, counts(tags, "atlassian", "atlassian-plugin-sdk", dates))
tagcounts = rbind(tagcounts, counts(tags, "atlassian", "atlassian-sourcetree", dates))
tagcounts = rbind(tagcounts, counts(tags, "atlassian", "atlassian-stash", dates))

tagcounts$Count = as.numeric(tagcounts$Count)
tagcounts = rbind(tagcounts, aggGroups(tagcounts, dates))



allTelerik = c( 5096, 31219, 28901, 26778, 33766, 26746, 13755, 25381, 20166, 23513, 34315,
24459, 32782, 26409, 21851, 16966, 18629, 29792, 26569,
32128, 33118, 32100, 31493, 33517, 29170, 33107, 33920, 31095, 27590, #kendo
13999, 16547, 26370, 26405, 31249, 24676, 16588, 10434, 19843, #randcontrol
5097, 9725, 9727, 9378, 22107, 32939, 30052, 15659, 10434,19843, # radcontrol
19030,21618, # Just
32299, #icenium
8643, 23048, 24999, 29093, #sitefinity
10159) #eqatec



allDevExpress = c(542,31761)

allXamarin = c(20215,31941,33423,31939,33010,31930,31303,30505,33011)

allSencha = c( 20424, 29475, 29208, 27268, 29996, 25658, 22637, 27879, 32954, 30999, 33022, 27297)

allAppcelerator = c(15182,22608)

allInfragistics = c(1322)
allComponentOne = c(6767)
allComponentArt = c(83656)
allSyncFusion = c(6247)

allAJAX = c(315, 15488, 30518, 13056, 7811, 13056)

allWPF = c(315, 15488, 30518, 13056, 7811, 13056)

allSilverlight = c( 316, 5789, 5019, 1410, 17145, 18042, 21381, 24100, 19412,
20000, 8972, 14158, 9412)

allWinForms = c( 1, 13437, 15941, 17612) 

allWindowsPhone = c( 10431, 26580, 24284, 28803, 25925, 31657, 24562, 30871,
30883, 33975, 30881)

allWindows8 = c(22256, 33283)

allWindows = c(10713, 20323, 22391, 23405, 19474, 4158, 24241, 18276, 22256,
33283, 16624, 4286, 14839, 19058, 21207, 29529, 27650, 32785, 18915, 16411,
1048, 7522, 21163, 10326,
22773,6071,17058,31598,26915,32960,19959,4104,9501,148,20245,4178,14885,20374,12287,29082,13590,
25419,181,23654,10431,26580,24284,28803,25925,31657,24562,30871,30871,30883,33975,30881,30591,1427,
13213,1904,232,24145,295,16609,8813,23253,30547,151,25734,5179,27626,29440,
614,576,21466,4269,12273,16304,18643,10663,20251,17471)

allOSX = c(155, 26768, 28915, 2323, 16868, 33370, 27417, 21037, 15173, 28229,
1647, 14099, 25597, 17487, 31179, 32461, 15374, 23636, 314, 27446, 33285, 28176, 9418, 952, 8462, 22967, 16158,
1081, 23217, 23629, 22891, 31201, 26030, 22942, 25599, 25546, 7281, 27260, 23177, 21570, 22810, 23038, 16177, 23090,
24077, 23468, 19540, 27776, 27898, 28838, 23876, 29687, 30087, 31704, 33297)

allLinux = c(64, 10837, 18286, 21969, 8271, 20648, 23088, 30739, 19692, 23326,
442, 22201, 24179, 25962, 28028, 29458, 30833, 5670, 11750, 13185, 18901, 14907, 32241, 27322,
31, 6056, 14594, 7670, 13478, 3704)


#tmp = tags[tags$TagID %in% allTelerik,]
#tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% allWPF),]
tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite", dates, allTelerik, allWPF))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-WPF-Suite", dates, allDevExpress,allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-WPF-Suite", tmp, dates, allXamarin,allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-WPF-Suite", tmp, dates, allAppcelerator,allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-WPF-Suite", tmp, dates, allSencha, allWPF))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-Silverlight-Suite", dates, allTelerik, allSilverlight))
tagcounts = rbind(tagcounts, aggGroups2("Infragistics-Silverlight-Suite", dates, allInfragistics,allSilverlight))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-Silverlight-Suite", dates, allComponentOne,allSilverlight))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-Silverlight-Suite", dates, allComponentArt,allSilverlight))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-Silverlight-Suite", dates, allSyncFusion, allSilverlight))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-WindowsPhone-Suite", dates, allTelerik, allWindowsPhone))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-WindowsPhone-Suite", dates, allDevExpress,allWindowsPhone))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-WindowsPhone-Suite", dates, allXamarin,allWindowsPhone))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-WindowsPhone-Suite", dates, allAppcelerator,allWindowsPhone))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-WindowsPhone-Suite", dates, allSencha, allWindowsPhone))


tagcounts$Count = as.numeric(tagcounts$Count)
makeTagPlots(tagcounts, dates, out)
write.table(tagcounts, file=sprintf("%s/tagcounts.csv", base), sep=",", row.names=F, col.names=F)


# TMP
#tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% allWindows),]
#tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite-Windows", tmp, dates))
#tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% allOSX),]
#tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite-OSX", tmp, dates))
#tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% allLinux),]
#tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite-Linux", tmp, dates))



