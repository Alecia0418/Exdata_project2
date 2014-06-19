##Set wd
setwd("~/Exdata_project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate the data to get sum of years needed
data.Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
data.Emissions$PM <- round(data.Emissions[,2]/1000,2)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

## Create plot1
## 1. Launch png graphics device
png(file = "plot1.png")

## 2. Create barplot
barplot(data.Emissions$PM, names.arg=data.Emissions$Group.1, col="blue",
        main=expression('Total Emissions in the US'),
        xlab="Year", ylab=expression("Total Emissions, PM"[2.5]))

## 3. Close Connection
dev.off()