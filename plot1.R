## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the *total* PM2.5 emission from 
#   **all** sources for each of the years 1999, 2002, 2005, and 2008.
png(file="plot1.png",width=480,height=480) #set width and height for consistent reproduction
plot(summ$year,summ$Emissions,xlab="Year",ylab="PM2.5 Emissions (Tons)",main="Decreasing Emissions over Time")
fit1 <- lm(Emissions ~ year,data= summ)
abline(fit1) #Adds a line to indicate the trend.

dev.off()