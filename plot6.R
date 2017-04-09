# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

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

## Create data frame with per-year and fips sums and subset to 
## EI.Sector contains "Vehicles" and fips == "24510" or "06037"
totalD.sub <- data.frame(aggregate(Emissions~year+fips,
        data=subset(totalD,fips %in% c("06037","24510") & grepl("Vehicles", EI.Sector)), sum ))

## Create location list. To be used later as legend
locations <- list("06037" = "Los Angeles","24510" = "Baltimore")

## Save to png
png("./plot6.png", width=480, height=480)

## Draw plot
ggplot(totalD.sub, aes(x=factor(year), y = Emissions)) + 
  geom_bar(stat = "identity",aes(fill=fips), position=position_dodge()) +
  labs(title = expression('PM'[2.5]*" Comparative Emissions (Motor Vehicles sources)"), 
  x = "Year", y = "Total Emissions (tons)") +
  scale_fill_discrete(labels=locations) + theme(legend.title=element_blank())

dev.off() ##Close device
