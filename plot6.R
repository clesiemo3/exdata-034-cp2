## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

NEI <- NEI[NEI$fips == "24510" | NEI$fips == "06037",] #Set to Baltimore City
SCC <- SCC[grep("Vehicle",SCC$EI.Sector),] #get motor vehicle sources
NS <- merge(NEI,SCC,by="SCC")
NS$City <- sapply(NS$fips,FUN=function(x){
    if(x=="24510") return("Baltimore")
    return("Los Angeles")
    }
)
gNEI <- group_by(NS,year,fips,City)
summ <- gNEI %>% summarize_each(funs(sum),Emissions)
png(file="plot6.png",width=480,height=480) #set width and height for consistent reproduction
qplot(data=summ, year,Emissions,facets= . ~ City,geom=c("point","smooth"),method="lm") + labs(title="Baltimore vs LA Vehicle Emissions over Time")
dev.off()