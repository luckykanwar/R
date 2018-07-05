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