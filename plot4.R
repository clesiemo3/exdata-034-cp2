## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(dplyr)

SCC <- SCC[grep("[Cc]oal",SCC$EI.Sector),] #get rows for coal sector
NS <- merge(NEI,SCC,by="SCC")
gNEI <- group_by(NS,year)
summ <- gNEI %>% summarize_each(funs(sum),Emissions)
png(file="plot4.png",width=480,height=480) #set width and height for consistent reproduction
plot(summ$year,summ$Emissions,xlab="Year",ylab="PM2.5 Emissions (Tons)",main="Coal Emissions over Time")
fit1 <- lm(Emissions ~ year,data= summ)
abline(fit1) #Adds a line to indicate the trend.

dev.off()