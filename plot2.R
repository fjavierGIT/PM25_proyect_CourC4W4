# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Read data files from working directory
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}

## Create data frame with per-year sums and subset to fips == "24510"
totalD.sub <- data.frame(aggregate(Emissions~year,
      data=subset(NEI,fips == "24510" & year %in% c(1999,2008) ), sum ))

## Save to png
png("./plot2.png", width=480, height=480)

## Draw plot
with(totalD.sub, barplot(
  Emissions,
  col = "yellow",
  names.arg = year,
  ylim = c(0, 4000),
  xlab="Year", ylab = "Total Emissions (tons)",
  main = expression('PM'[2.5]*" Total Emisions (Baltimore City, Maryland)")
))

dev.off() ##Close device
