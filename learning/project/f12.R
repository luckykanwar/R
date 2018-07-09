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

# Calculate the fastest laps
results$fastestLapSpeed <- as.numeric(results$fastestLapSpeed) #convert fastest lap speed from factor to numeric

# function to convert laptimes from characters to numeric 
calcLapTimes <- function(lapTime){
  if(length(lapTime) > 0){
    sec <- as.numeric(strsplit(lapTime,":")[[1]][2])
    min <- as.numeric(strsplit(lapTime,":")[[1]][1])
    lapTimeSec <- min * 60 + sec
    return(lapTimeSec)
  }
  else{
    return(0)
  }
}

lapTimesresults$lapTimes <- sapply(as.character(results$fastestLapTime), calcLapTimes)
races$date <- as.Date(races$date)
races$name<-gsub(" Grand Prix","",races$name)
results_modified <- merge(results, races, by="raceId")
lap_times_per_year <- results_modified[c("name","lapTimes","year")]
aggregate(lap_times_per_year, lap_times_per_year[c("year","name")], mean, na.rm = TRUE)
avg_lapTimes_per_year_filtered <- subset(avg_lapTimes_per_year[c("name", "lapTimes", "year")], year>=2004)

# Faceted plot to display the average speed over years at specific Grand Prix venues
ggplot(avg_lapTimes_per_year_filtered) + geom_line(aes(x=avg_lapTimes_per_year_filtered$year, y=avg_lapTimes_per_year_filtered$lapTimes, group=avg_lapTimes_per_year_filtered$name, color = avg_lapTimes_per_year_filtered$name)) + facet_wrap(~avg_lapTimes_per_year_filtered$name) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + xlab("Year") + ylab("Lap time in seconds") + ggtitle("Lap Times over the years per Grand Prix") + guides(color=guide_legend(title="Grand Prix"))

