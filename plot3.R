## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#   which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#   Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
library(dplyr)
library(ggplot2)

NEI <- NEI[NEI$fips == "24510",] #Set to Baltimore City
gNEI <- group_by(NEI,year,type) 
summ <- gNEI %>% summarize_each(funs(sum),Emissions)
png(file="plot3.png",width=480,height=480) #set width and height for consistent reproduction
qplot(data=summ, year,Emissions,facets= . ~ type,geom=c("point","smooth"),method="lm") + labs(title="Emissions over Time by Type")

dev.off()