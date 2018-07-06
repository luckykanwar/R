circuits <- read.csv("~/R/learning/project/f1data/circuits.csv")
constructorResults <- read.csv("~/R/learning/project/f1data/constructorResults.csv")
constructors <- read.csv("~/R/learning/project/f1data/constructors.csv")
constructorStandings <- read.csv("~/R/learning/project/f1data/constructorStandings.csv")
drivers <- read.csv("~/R/learning/project/f1data/drivers.csv")
driverStandings <- read.csv("~/R/learning/project/f1data/driverStandings.csv")
laptimes <- read.csv("~/R/learning/project/f1data/laptimes.csv")
pitstops <- read.csv("~/R/learning/project/f1data/pitstops.csv")
qualifying <- read.csv("~/R/learning/project/f1data/qualifying.csv")
races <- read.csv("~/R/learning/project/f1data/races.csv")
results <- read.csv("~/R/learning/project/f1data/results.csv")
seasons <- read.csv("~/R/learning/project/f1data/seasons.csv")
status <- read.csv("~/R/learning/project/f1data/status.csv")


results_drivers <- merge(x=results, y=drivers, by=driverId)
results_drivers_constrs <- merge(x=results_drivers, y=constructors, by="constructorId")

results_drivers_constrs_races <- merge(x=results_drivers_constrs, y=races, by="raceId" )

subset_results_drivers_constrs_races <- results_drivers_constrs_races[c("driverId", "positionOrder","rank", "forename", "surname", "name.y", "year")]

#Preliminary analysis of the number of races held per year. We can see that the number of races have grown over the years

# line graph to represent the number of races held each year
ggplot(races_per_year) + geom_line(aes(x=races_per_year$raceYear, y=races_per_year$raceCount, group=1))

#line graph to represent the number ofraces heald each year with labels at a 45 angle
ggplot(races_per_year) + geom_line(aes(x=races_per_year$raceYear, y=races_per_year$raceCount, group=1)) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ggtitle("Races held per year") + xlab("Race Count") + ylab("Year")

#bar graph representing number of races per year
ggplot(races_per_year) + geom_bar(aes(x=races_per_year$raceYear, y=races_per_year$raceCount, fill=races_per_year$raceCount), stat="identity") + coord_flip() + ggtitle("Races held per year") + xlab("Race Count") + ylab("Year")