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
ggplot(most_races_by_drivers) + geom_bar(aes(x=reorder(most_races_by_drivers$forename,most_races_by_drivers$n) , y=most_races_by_drivers$n, fill=most_races_by_drivers$forename), stat="identity") + coord_flip() + ggtitle("Drivers with the most race participation in F1") + labs(x = "Driver", y = "Race count", fill = "Tracks")

# Drivers with the most race wins
head(results_drivers)
head(results_drivers_constrs_races)
colnames(results_drivers_constrs_races)
sub_results_drivers_constrs_races <- results_drivers_constrs_races[c("position","driverRef", "forename", "surname", "nationality.x", "constructorRef", "name.x","year","name.y")]
head(sub_results_drivers_constrs_races,1)

# Filter the position = 1 from the above dataset
sub_results_drivers_constrs_races <- subset(sub_results_drivers_constrs_races, select = -c("year"))
winnerData <- sub_results_drivers_constrs_races %>% filter(position == 1) %>% select(driverRef, name.y)%>%  group_by(driverRef, name.y) %>% summarize(count=n())
final_winnerData <- winnerData %>% group_by(driverRef) %>% summarize(TotalWins = sum(count)) %>% filter(TotalWins >= 10)
ggplot(final_winnerData) + geom_bar(aes(x=final_winnerData$driverRef, y=final_winnerData$TotalWins), stat="identity") + coord_flip() + ggtitle("Drivers with the most race wins in F1") + xlab("Race Count") + ylab("Driver Name") + guides(color=guide_legend(title="Drivers"))

# Driver wins per track
subWinnerData <- subset(winnerData, winnerData$count>=2)
ggplot(subWinnerData) + geom_bar(aes(x=subWinnerData$driverRef, y=subWinnerData$count, fill=subWinnerData$name.y), stat="identity") + ggtitle("Drivers with the most race wins per track", "Drivers with equal to or more than 2 race wins per track displayed") + labs(x = "Driver", y = "Race count", fill = "Tracks")  + coord_flip()



