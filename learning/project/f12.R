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
