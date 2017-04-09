# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

## Read data files from working directory
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}

## Create data frame with per-year sums
totalD <- aggregate(Emissions~year,data=NEI, FUN = sum)

## Save to png
png("./plot1.png", width=480, height=480)

## Draw plot
with(totalD, barplot(
  Emissions,
  col = "red",
  names.arg = year,
  ylim = c(0, 8e+06),
  xlab="Year", ylab = "Total Emissions (tons)",
  main = expression('PM'[2.5]*" US Total Emissions")
  ))

dev.off() ##Close device
