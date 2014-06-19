##Set wd
setwd("~/Exdata_project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Set ggplot
library(ggplot2)
library(plyr)

# Pull just coal-related instances from SCC
coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge NEI and Coal data
neicoal <- merge(x=NEI, y=coal, by='SCC')
agg.neicoal <- aggregate(neicoal[, 'Emissions'], by=list(neicoal$year), sum)
colnames(agg.neicoal) <- c('Year', 'Emissions')

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?


## Create plot4
## 1. Launch png graphics device
png(file = "plot4.png")

## 2. Create plot
plot(agg.neicoal, type="o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions from Coal Combustion in the US", 
     col="blue")

## 3. Close Connection
dev.off()