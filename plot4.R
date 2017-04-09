# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library("ggplot2")

## Read data files from working directory
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

## Merge data frames to new one.  Common column = "SCC"
totalD <- merge(NEI,SCC,by="SCC")

## Create data frame with per-year sums and subset to EI.Sector contains "Coal"
totalD.sub <- data.frame(aggregate(Emissions~year,
        data=subset(totalD,grepl("Coal", EI.Sector)), sum ))

## Save to png
png("./plot4.png", width=480, height=480)

## Draw plot

ggplot(totalD.sub, aes(x=factor(year), y = Emissions)) + geom_bar(stat = "identity", fill = "blue") +
        labs(title = expression('PM'[2.5]*" US Emissions (Coal Combustion sources)"), 
        x = "Year", y = "Total Emissions (tons)")

dev.off() ##Close device
