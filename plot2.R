##Set wd
setwd("~/Exdata_project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset for Baltimore City, MD
BC <- subset(NEI, fips=='24510')
agg.BC <- with(BC, aggregate(Emissions, by = list(year), sum))
colnames(agg.BC) <- c("year", "Emissions")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.

## Create plot2
## 1. Launch png graphics device
png(file = "plot2.png")

## 2. Create plot
barplot(agg.BC$Emissions, names.arg=agg.BC$year, 
        ylab = expression("Total Emissions, PM"[2.5]), 
        xlab = "Year", main = "Total Emissions for Baltimore County", col="blue",
        ylim=c(0, 3500))

## 3. Close Connection
dev.off()