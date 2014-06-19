##Set wd
setwd("~/Exdata_project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Set ggplot
library(ggplot2)
library(plyr)

# Subset for Baltimore City, MD
BC <- subset(NEI, fips=='24510')

# Use plyr package to combine data
BC.type <- ddply(BC, .(type, year), summarize, Emissions = sum(Emissions))

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question.

## Create plot3
## 1. Launch png graphics device
png(file = "plot3.png")

## 2. Create plot
qplot(year, Emissions, data = BC.type, group = type, color = type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in US by Type") + theme_bw()

## 3. Close Connection
dev.off()