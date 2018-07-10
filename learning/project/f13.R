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

results$fastestLapSpeed<-as.numeric(results$fastestLapSpeed)
convertFastestLap<-function(x){
  if(length(x)>0){
    curMinute<-as.numeric(strsplit(x,":")[[1]][1])
    curSecond<-as.numeric(strsplit(strsplit(x,":")[[1]][2],"\\.")[[1]][1])
    return(curMinute*60 + curSecond)
  }
  else if(length(x)==0){
    return(NA)
  }
}
results$fastestLapTimeNum<-sapply(results$fastestLapTime, convertFastestLap)

#convert character to Date
races$date<-as.Date(races$date,"%Y-%m-%d")
#remove "Grand Prix" in the name
races$name<-gsub(" Grand Prix","",races$name)

results_2<-left_join(
  results %>% dplyr::select(-time, -fastestLapTime), 
  races %>% dplyr::select(-time, -url), 
  by='raceId')

results_test <- inner_join(
  races %>% dplyr::select(raceId, year, name, location),
  results %>% dplyr::select(raceId, fastestLapTime, fastestLapSpeed),
  by = "raceId")
  
race_modified <- left_join(
  races %>% select(-name,-url), 
  circuits %>% select(-url), 
  by='circuitId')

  results_3 <- results_2 %>% 
  dplyr::filter(year>2004) %>%
  dplyr::group_by(name, year) %>%
  summarize(medianFastestLapSpeed = median(fastestLapSpeed, na.rm=T)) %>%
  ggplot(aes(x=factor(year),y= medianFastestLapSpeed,color=medianFastestLapSpeed)) + 
    geom_point() + 
    scale_color_gradientn(name="",colours=rev(viridis::viridis(20))) +
    theme(
      axis.text.x = element_text(size=6,angle=45),
      strip.text.x = element_text(size = 10)) + facet_wrap(~name,ncol=9) + 
    labs(title='Fastest Lap per Circuit, from 2005 to 2017',
         subtitle='speed in km/h') +
    guides(color=FALSE)
  
  
  results_2 %>% 
    dplyr::filter(year>2004) %>% 
    dplyr::group_by(name,year) %>% 
    summarize(medianFastestLapSpeed = median(fastestLapSpeed,na.rm=T)) %>% 
    ggplot(aes(x=factor(year),y= medianFastestLapSpeed,color=medianFastestLapSpeed)) + 
    geom_boxplot(alpha=1) + 
    geom_jitter(shape=16,position=position_jitter(0.2),size=1.5) + 
    geom_smooth(method='loess',aes(group=1),color='red',lty=2,size=.5) +
    scale_color_gradientn(name="",colours=rev(viridis::viridis(20))) + 
    labs(title='Fastest Lap per Year',
         subtitle='in km/h, grouped by Grand Prix') + 
    guides(color = FALSE)