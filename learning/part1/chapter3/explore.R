custdata <- read.table("custdata.tsv", header = T, sep="\t")
custdata2 <- read.table("custdata2.tsv", header = T, sep="\t")
ggplot(custdata) + geom_histogram(aes(x=age), binwidth=5, fill="gray")
ggplot(custdata) + geom_density(aes(x=income)) +
  scale_x_log10(breaks=c(100,1000,10000,100000), labels=dollar) +
  annotation_logticks(sides="bt")

ggplot(custdata) + geom_bar(aes(x=marital.stat), fill="gray")
ggplot(custdata) + geom_bar(aes(x=state.of.res), fill="gray") + coord_flip() + theme(axis.text.y=element_text(size=rel(0.8)))


#sorted categories
statesums <- table(custdata$state.of.res)
statef <- as.data.frame(statesums)
colnames(statef) <- c("state","count")
summary(statef)
statef <- transform(statef, state=reorder(state,count))
summary(statef)
ggplot(statef) + geom_bar(aes(x=state, y=count), fill="gray", stat="identity") + coord_flip() + theme(axis.text.y=element_text(size=rel(0.8)))



#dummy data 

months <-rep(c("jan", "feb", "mar", "apr", "may", "jun", 
               "jul", "aug", "sep", "oct", "nov", "dec"), 2)
chickens <-c(1, 2, 3, 3, 3, 4, 5, 4, 3, 4, 2, 2)
eggs <-c(0, 8, 10, 13, 16, 20, 25, 20, 18, 16, 10, 8)
values <-c(chickens, eggs)
type <-c(rep("chickens", 12), rep("eggs", 12))
mydata <-data.frame(months, values)
p <-ggplot(mydata, aes(months, values))
p +geom_bar(stat = "identity")
mydata$months <-factor(mydata$months, 
                       levels = c("jan", "feb", "mar", "apr", "may", "jun",
                                  "jul", "aug", "sep", "oct", "nov", "dec"))

p <-ggplot(mydata, aes(months, values))
p + geom_bar(stat = "identity", aes(fill = type))  # this will show two types in the bar chart

p <-ggplot(mydata, aes(months, values))
p + geom_bar(stat = "identity", aes(fill = type), position = "dodge") # this will show bars stacked next to each other
  +xlab("Months") + ylab("Count") +
  ggtitle("Chickens & Eggs") +
  theme_bw()


