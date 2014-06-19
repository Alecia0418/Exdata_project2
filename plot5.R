##Set wd
setwd("~/Exdata_project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Set ggplot
library(ggplot2)
library(plyr)

# Pull just motor vehicle instances from SCC
motor = SCC[grepl("motor", SCC$Short.Name, ignore.case=TRUE),]
id <- as.character(motor$SCC)
NEI$SCC <- as.character(NEI$SCC)
NEImotor <- NEI[NEI$SCC %in% id, ]

# Narrow to Baltimore City
BC.motor<-subset(NEImotor, fips == "24510" )

BCmotor <- aggregate(BC.motor[, 'Emissions'], by=list(BC.motor$year), sum)
colnames(BCmotor) <- c('year', 'Emissions')

agg.BCmotor <- with(BCmotor, aggregate(Emissions, by = list(year), 
                                                         sum))

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


## Create plot5
## 1. Launch png graphics device
png(file = "plot5.png")

## 2. Create plot
plot(agg.BCmotor, type= "o",
        ylab = expression("Total Emissions, PM"[2.5]), 
        xlab = "Year", main = "Total Emissions from Motor Vehicles", 
        col="blue")

## 3. Close Connection
dev.off()