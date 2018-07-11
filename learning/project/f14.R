# Greatest drivers of all times based on number of wins in their careers

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

results_drivers <- inner_join(
  results,
  drivers,
  by = 'driverId'
)

# Get count of races by each driver
count_result_drivers <- count(results_drivers, forename, surname, nationality)
count_result_drivers <- arrange(count_result_drivers, n)
most_races_by_drivers <- subset(count_result_drivers_sorted, n > 200)

# Plots the racers with most races
ggplot(most_races_by_drivers) + geom_bar(aes(x=most_races_by_drivers$forename, y=most_races_by_drivers$n), stat="identity") + coord_flip() + ggtitle("Drivers with the most race participation in F1") + xlab("Race Count") + ylab("Driver Name") + guides(color=guide_legend(title="Drivers"))

