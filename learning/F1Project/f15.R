circuits <- read.csv("~/R/learning/project/f1data/circuits.csv",stringsAsFactors=F,sep=',')
constructorResults <- read.csv("~/R/learning/project/f1data/constructorResults.csv", stringsAsFactors=F,sep=',')
constructors <- read.csv("~/R/learning/project/f1data/constructors.csv",stringsAsFactors=F,sep=',')
constructorStandings <- read.csv("~/R/learning/project/f1data/constructorStandings.csv", stringsAsFactors=F,sep=',')
drivers <- read.csv("~/R/learning/project/f1data/drivers.csv", stringsAsFactors=F,sep=',')
driverStandings <- read.csv("~/R/learning/project/f1data/driverStandings.csv", stringsAsFactors=F,sep=',')
laptimes <- read.csv("~/R/learning/project/f1data/laptimes.csv", stringsAsFactors=F,sep=',')
pitstops <- read.csv("~/R/learning/project/f1data/pitstops.csv", stringsAsFactors=F,sep=',')
qualifying <- read.csv("~/R/learning/project/f1data/qualifying.csv", stringsAsFactors=F,sep=',')
races <- read.csv("~/R/learning/project/f1data/races.csv", stringsAsFactors=F,sep=',')
results <- read.csv("~/R/learning/project/f1data/results.csv", stringsAsFactors=F,sep=',')
seasons <- read.csv("~/R/learning/project/f1data/seasons.csv", stringsAsFactors=F,sep=',')
status <- read.csv("~/R/learning/project/f1data/status.csv", stringsAsFactors=F,sep=',')

# Numer of races entered vs races won by a driver comparison
results_drivers <- inner_join(
  results,
  drivers,
  by = 'driverId'
)

winnerResults <- subset(results_drivers[c("position", "driverRef")], results_drivers$position == 1)

winnerResults <- winnerResults %>% group_by(driverRef) %>% summarize(count=n())

participation <- results_drivers[c("driverRef")] %>% group_by(driverRef) %>% summarize(count=n())

winVsParticipate <- inner_join(
  winnerResults, 
  participation,
  by = "driverRef"
)
colnames(winVsParticipate) <- c("Driver","Wins","TotalRaces")
winVsParticipate$winPercent <- (winVsParticipate$Wins / winVsParticipate$TotalRaces) * 100
winVsParticipateTenMostSuccess <- tail(winVsParticipate[order(winVsParticipate$winPercent),] %>% filter(TotalRaces >= 10), 30)
ggplot(winVsParticipateTenMostSuccess) + geom_bar(aes(x=reorder(winVsParticipateTenMostSuccess$Driver,winVsParticipateTenMostSuccess$winPercent), y=winVsParticipateTenMostSuccess$winPercent), stat="identity") + ggtitle("30 most successful F1 drivers","Win vs Total Races Comparison") + labs(x = "Driver", y = "Win Percentage")  + coord_flip()
