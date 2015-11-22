## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
NEI <- NEI[NEI$fips == "24510",] #Set to Baltimore City

SCC <- SCC[grep("Vehicle",SCC$EI.Sector),] #get motor vehicle sources
NS <- merge(NEI,SCC,by="SCC")
gNEI <- group_by(NS,year)
summ <- gNEI %>% summarize_each(funs(sum),Emissions)
png(file="plot5.png",width=480,height=480) #set width and height for consistent reproduction
plot(summ$year,summ$Emissions,xlab="Year",ylab="PM2.5 Emissions (Tons)",main="Baltimore Vehicle Emissions over Time")
fit1 <- lm(Emissions ~ year,data= summ)
abline(fit1) #Adds a line to indicate the trend.

dev.off()