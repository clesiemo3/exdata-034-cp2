## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
library(dplyr)
NEI <- NEI[NEI$fips == "24510",] #Set to Baltimore City
gNEI <- group_by(NEI,year)
summ <- gNEI %>% summarize_each(funs(sum),Emissions)
png(file="plot2.png",width=480,height=480) #set width and height for consistent reproduction
plot(summ$year,summ$Emissions,xlab="Year",ylab="PM2.5 Emissions (Tons)",main="Decreasing Emissions over Time in Baltimore")
fit1 <- lm(Emissions ~ year,data= summ)
abline(fit1) #Adds a line to indicate the trend.

dev.off()