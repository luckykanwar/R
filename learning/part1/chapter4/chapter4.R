load("~/R/learning/part1/chapter4/exampleData.rData")

custdata$is.employed.fix <- ifelse(is.na(custdata$is.employed),"missing", ifelse(custdata$is.employed == T, "employed", "unemployed"))

custdata$is.employed.fix <- ifelse(is.na(custdata$is.employed),"not in active work force", ifelse(custdata$is.employed == T, "employed", "unemployed"))

meanIncome <- mean(custdata$Income, na.rm = TRUE)
custdata$income.fix <- ifelse(is.na(custdata$Income), meanIncome, custdata$Income)
summary(custdata$income.fix)

breaks <- c(0,10000, 50000, 100000, 250000, 1000000)

income.groups <- cut(custdata$income, breaks, include.lowest = TRUE)
income.groups
income.groups <- as.character(income.groups)
income.groups <- ifelse(is.na(income.groups),"no income", income.groups)
summary(income.groups)

# normalizing values
summary(custdata$age)
