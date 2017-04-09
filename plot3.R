# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library("ggplot2")

## Read data files from working directory
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}

## Create data frame with per-year + type sums and subset to fips == "24510"
totalD.sub <- data.frame(aggregate(Emissions~year+type, 
      data=subset(NEI,fips == "24510" & year %in% c(1999,2008)), sum ))

## Save to png
png("./plot3.png", width=480, height=480)

## Draw plot
g <- qplot(year,Emissions, data = totalD.sub)
g + geom_line(aes(color = type)) + labs(title = expression('PM'[2.5]*" Baltimore City Total Emisions")) + 
      labs(y = "Total Emissions (tons)") + scale_x_continuous(breaks = c(1999,2008))

dev.off() ##Close device
