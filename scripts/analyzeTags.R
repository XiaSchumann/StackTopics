
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
13999, 16547, 26370, 26405, 31249, 24676, 16588, 10434, 19843, #radcontrol
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
allSelenium = c(853,29408,27868,27869,10519,4055,32876,14417,3415,29558,19968,23159)
allSlickgrid = c(20958)


allGrid =
c(423,9850,19378,22982,18749,1227,6212,2658,32093,20476,3400,10357,11000,17523,33255,20400,18895,
10564,13056,1000,21075,10662,21194,13171,23135,28826,10724,13284,31493,6284,20638,26899,30043,20314,13755,
10434,19843,20958,4055,32876)

allChart = c(15653,29895, 688, 28082, 13488, 7645, 24760, 13999, 27268, 28901)

allRTB = c(5665,31209,30947,13879,12643,6040,7747,26746,1359,1906,10437,13574,30004,26409)

allAJAX = c(303, 394, 13562,31219,
31616, 12313, 22530, 8742, 19507, 23248, 17750, 9955, 3874, 9001, 11602, 24595,
15418, 2861, 14699, 10173, 30854, 21368, 10725, 17420, 20588, 25170, 1304,
27192)

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

tagcounts = rbind(tagcounts, aggGroups2("WPF-Suite", dates, allWPF, allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Silverlight-Suite", dates, allSilverlight, allSilverlight))
tagcounts = rbind(tagcounts, aggGroups2("WindowsPhone-Suite", dates, allWindowsPhone, allWindowsPhone))
tagcounts = rbind(tagcounts, aggGroups2("Windows8-Suite", dates, allWindows8, allWindows8))
tagcounts = rbind(tagcounts, aggGroups2("AJAX-Suite", dates, allAJAX, allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("Winforms-Suite", dates, allWinForms, allWinForms))

tagcounts = rbind(tagcounts, aggGroups2("Chart-Control", dates, allChart, allChart))
tagcounts = rbind(tagcounts, aggGroups2("Grid-Control", dates, allGrid, allGrid))
tagcounts = rbind(tagcounts, aggGroups2("RichTextBox-Control", dates, allRTB, allRTB))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-Company", dates, allTelerik, allTelerik))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-Company", dates, allDevExpress, allDevExpress))
tagcounts = rbind(tagcounts, aggGroups2("Infragistics-Company", dates, allInfragistics, allInfragistics))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-Company", dates, allXamarin, allXamarin))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-Company", dates, allAppcelerator, allAppcelerator))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-Company", dates, allSencha, allSencha))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-Company", dates, allComponentOne,allComponentOne))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-Company", dates, allComponentArt, allComponentArt))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-Company", dates, allSyncFusion, allSyncFusion))


tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite", dates, allTelerik, allWPF))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-WPF-Suite", dates, allDevExpress,allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Infragistics-WPF-Suite", dates, allInfragistics,allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-WPF-Suite", dates, allXamarin,allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-WPF-Suite", dates, allAppcelerator,allWPF))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-WPF-Suite", dates, allSencha, allWPF))

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
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-WindowsPhone-Suite", dates, allComponentOne,allWindowsPhone))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-WindowsPhone-Suite", dates, allComponentArt,allWindowsPhone))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-WindowsPhone-Suite", dates, allSyncFusion, allWindowsPhone))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-Grid", dates, allTelerik, allGrid))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-Grid", dates, allDevExpress,allGrid))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-Grid", dates, allXamarin,allGrid))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-Grid", dates, allAppcelerator,allGrid))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-Grid", dates, allSencha, allGrid))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-Grid", dates, allComponentOne,allGrid))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-Grid", dates, allComponentArt,allGrid))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-Grid", dates, allSyncFusion, allGrid))
tagcounts = rbind(tagcounts, aggGroups2("Selenium-Grid", dates, allSelenium, allGrid))
tagcounts = rbind(tagcounts, aggGroups2("Slickgrid-Grid", dates, allSlickgrid, allGrid))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-Winforms-Suite", dates, allTelerik, allWinForms))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-Winforms-Suite", dates, allDevExpress,allWinForms))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-Winforms-Suite", dates, allXamarin,allWinForms))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-Winforms-Suite", dates, allAppcelerator,allWinForms))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-Winforms-Suite", dates, allSencha, allWinForms))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-Winforms-Suite", dates, allComponentOne,allWinForms))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-Winforms-Suite", dates, allComponentArt,allWinForms))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-Winforms-Suite", dates, allSyncFusion, allWinForms))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-Windows8-Suite", dates, allTelerik, allWindows8))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-Windows8-Suite", dates, allDevExpress,allWindows8))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-Windows8-Suite", dates, allXamarin,allWindows8)) 
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-Windows8-Suite", dates, allAppcelerator,allWindows8))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-Windows8-Suite", dates, allSencha, allWindows8))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-Windows8-Suite", dates, allComponentOne,allWindows8))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-Windows8-Suite", dates, allComponentArt,allWindows8))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-Windows8-Suite", dates, allSyncFusion, allWindows8))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-AJAX-Suite", dates, allTelerik, allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-AJAX-Suite", dates, allDevExpress,allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-AJAX-Suite", dates, allXamarin,allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-AJAX-Suite", dates, allAppcelerator,allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-AJAX-Suite", dates, allSencha, allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-AJAX-Suite", dates, allComponentOne,allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-AJAX-Suite", dates, allComponentArt,allAJAX))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-AJAX-Suite", dates, allSyncFusion, allAJAX))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-Chart", dates, allTelerik, allChart))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-Chart", dates, allDevExpress,allChart))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-Chart", dates, allXamarin,allChart))
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-Chart", dates, allAppcelerator,allChart))
tagcounts = rbind(tagcounts, aggGroups2("Sencha-Chart", dates, allSencha, allChart))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-Chart", dates, allComponentOne,allChart))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-Chart", dates, allComponentArt,allChart))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-Chart", dates, allSyncFusion, allChart))

tagcounts = rbind(tagcounts, aggGroups2("Telerik-RTB", dates, allTelerik, allRTB))
tagcounts = rbind(tagcounts, aggGroups2("DevExpress-RTB", dates, allDevExpress,allRTB))
tagcounts = rbind(tagcounts, aggGroups2("Xamarin-RTB", dates, allXamarin,allRTB)) 
tagcounts = rbind(tagcounts, aggGroups2("Appcelerator-RTB", dates, allAppcelerator,allRTB)) 
tagcounts = rbind(tagcounts, aggGroups2("Sencha-RTB", dates, allSencha, allRTB))
tagcounts = rbind(tagcounts, aggGroups2("ComponentOne-RTB", dates, allComponentOne,allRTB))
tagcounts = rbind(tagcounts, aggGroups2("ComponentArt-RTB", dates, allComponentArt,allRTB))
tagcounts = rbind(tagcounts, aggGroups2("SyncFusion-RTB", dates, allSyncFusion, allRTB))

tagcounts$Count = as.numeric(tagcounts$Count)

makeTagPlots(tagcounts, dates, out)

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_WPF-Suite.png", out), "WPF Suite", c("WPF-Suite"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Silverlight-Suite.png", out), "Silverlight Suite", c("Silverlight-Suite"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_WindowsPhone-Suite.png", out), "WindowsPhone Suite", c("WindowsPhone-Suite"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Windows8-Suite.png", out), "Windows8 Suite", c("Windows8-Suite"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_AJAX-Suite.png", out), "AJAX Suite", c("AJAX-Suite"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Chart-Control.png", out), "Chart-Control", c("Chart-Control"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Grid-Control.png", out), "Grid-Control", c("Grid-Control"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_RichTextBox-Control.png", out), "RichTextBox-Control", c("RichTextBox-Control"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Telerik-Company.png", out), "Telerik-Company", c("Telerik-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_DevExpress-Company.png", out), "DevExpress-Company", c("DevExpress-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Infragistics-Company.png", out), "Infragistics-Company", c("Infragistics-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Xamarin-Company.png", out), "Xamarin-Company", c("Xamarin-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Appcelerator-Company.png", out), "Appcelerator-Company", c("Appcelerator-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_Sencha-Company.png", out), "Sencha-Company", c("Sencha-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_ComponentOne-Company.png", out), "ComponentOne-Company", c("ComponentOne-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_ComponentArt-Company.png", out), "ComponentArt-Company", c("ComponentArt-Company"))

makeComparisonPlot(tagcounts, dates, 
sprintf("%s/tags_SyncFusion-Company.png", out), "SyncFusion-Company", c("SyncFusion-Company"))


makeComparisonPlot(tagcounts, dates, sprintf("%s/tags_wpf-suite-by-company.png", out), "WPF
Suite By Company", 
    c("Telerik-WPF-Suite", "DevExpress-WPF-Suite", "Infragistics-WPF-Suite"))

makeComparisonPlot(tagcounts, dates,
sprintf("%s/tags_silverlight-suite-by-company.png",
out), "Silverlight Suite By Company", 
    c("Telerik-Silverlight-Suite", "Infragistics-Silverlight-Suite","ComponentOne-Silverlight-Suite",
"ComponentArt-Silverlight-Suite", "SyncFusion-Silverlight-Suite"))


makeComparisonPlot(tagcounts, dates,
sprintf("%s/tags_windowsphone-suite-by-company.png",
out), "Windows Phone Suite By Company", 
    c("Telerik-WindowsPhone-Suite", "DevExpress-WindowsPhone-Suite",
"Xamarin-WindowsPhone-Suite", "Appcelerator-WindowsPhone-Suite",
"Sencha-WindowsPhone-Suite","ComponentOne-WindowsPhone-Suite",
"ComponentArt-WindowsPhone-Suite", "SyncFusion-WindowsPhone-Suite"))

makeComparisonPlot(tagcounts, dates, sprintf("%s/tags_grid-by-company.png",
out), "Grid Control By Company", 
    c("Telerik-Grid", "DevExpress-Grid", "Xamarin-Grid", "Appcelerator-Grid",
"Sencha-Grid","ComponentOne-Grid", "ComponentArt-Grid", "SyncFusion-Grid",
"Selenium-Grid", "Slickgrid-Grid"))

makeComparisonPlot(tagcounts, dates, sprintf("%s/tags_winforms-suite-by-company.png",
out), "Winforms Suite By Company", 
    c("Telerik-Winforms-Suite", "DevExpress-Winforms-Suite",
"Xamarin-Winforms-Suite", "Appcelerator-Winforms-Suite",
"Sencha-Winforms-Suite","ComponentOne-Winforms-Suite",
"ComponentArt-Winforms-Suite", "SyncFusion-Winforms-Suite"))

makeComparisonPlot(tagcounts, dates, sprintf("%s/tags_windows8-suite-by-company.png",
out), "Windows 8 Suite By Company", 
    c("Telerik-Windows8-Suite", "DevExpress-Windows8-Suite",
"Xamarin-Windows8-Suite", "Appcelerator-Windows8-Suite",
"Sencha-Windows8-Suite","ComponentOne-Windows8-Suite",
"ComponentArt-Windows8-Suite", "SyncFusion-Windows8-Suite"))


makeComparisonPlot(tagcounts, dates, sprintf("%s/tags_ajax-suite-by-company.png",
out), "AJAX Suite By Company", 
    c("Telerik-AJAX-Suite", "DevExpress-AJAX-Suite",
"Xamarin-AJAX-Suite", "Appcelerator-AJAX-Suite",
"Sencha-AJAX-Suite","ComponentOne-AJAX-Suite",
"ComponentArt-AJAX-Suite", "SyncFusion-AJAX-Suite"))

makeComparisonPlot(tagcounts, dates, sprintf("%s/tags_chart-by-company.png",
out), "Chart Control By Company", 
    c("Telerik-Chart", "DevExpress-Chart",
"Xamarin-Chart", "Appcelerator-Chart",
"Sencha-Chart","ComponentOne-Chart",
"ComponentArt-Chart", "SyncFusion-Chart"))

makeComparisonPlot(tagcounts, dates, sprintf("%s/tags_rtb-by-company.png",
out), "RichTextBox Control By Company", 
    c("Telerik-RTB", "DevExpress-RTB",
"Xamarin-RTB", "Appcelerator-RTB",
"Sencha-RTB","ComponentOne-RTB",
"ComponentArt-RTB", "SyncFusion-RTB"))



write.table(tagcounts, file=sprintf("%s/tagcounts.csv", base), sep=",", row.names=F, col.names=F)


# TMP
#tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% allWindows),]
#tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite-Windows", tmp, dates))
#tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% allOSX),]
#tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite-OSX", tmp, dates))
#tmp = tags[tags$TopicID %in% tmp$TopicID & (tags$TagID %in% allLinux),]
#tagcounts = rbind(tagcounts, aggGroups2("Telerik-WPF-Suite-Linux", tmp, dates))



