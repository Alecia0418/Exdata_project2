##Set wd
setwd("~/Exdata_project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Set ggplot/plyr
library(ggplot2)
library(plyr)

# Pull just motor vehicle instances from SCC
motor = SCC[grepl("motor", SCC$Short.Name, ignore.case=TRUE),]
id <- as.character(motor$SCC)
NEI$SCC <- as.character(NEI$SCC)
NEImotor <- NEI[NEI$SCC %in% id, ]


# Narrow to Baltimore City and LA
BC.motor<-subset(NEImotor, fips == "24510" )
BCmotor <- aggregate(BC.motor[, 'Emissions'], by=list(BC.motor$year), sum)
colnames(BCmotor) <- c('year', 'Emissions')

agg.BCmotor <- with(BCmotor, aggregate(Emissions, by = list(year), 
                                                         sum))

LA.motor<-subset(NEImotor, fips == "06037" )
LAmotor <- aggregate(LA.motor[, 'Emissions'], by=list(LA.motor$year), sum)
colnames(LAmotor) <- c('year', 'Emissions')

agg.LAmotor <- with(LAmotor, aggregate(Emissions, by = list(year), 
                                       sum))

# Create groups for legend so they are easily read
agg.BCmotor$group <- rep("Baltimore County", length(agg.BCmotor[,1]))

agg.LAmotor$group <- rep("Los Angeles County", length(agg.LAmotor[,1]))

# Combine datasets
totaldata <- rbind(agg.LAmotor, agg.BCmotor)
colnames(totaldata) <- c("Year", "Emissions", "Group")
totaldata$Year<-as.character(totaldata$Year)

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == 06037). 
# Which city has seen greater changes over time in motor vehicle emissions?


## Create plot6
## 1. Launch png graphics device
png(file = "plot6.png")

## 2. Create plot
qplot(x=Year, y=Emissions, fill=Group, geom="bar", stat="identity", 
      position="dodge", data=totaldata, xlab="Year", ylab=expression("Total Emissions, PM"[2.5]), 
      main="Comparison of Total Emissions Between\n Los Angeles and Baltimore Counties") + 
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0)) + 
  guides(fill=guide_legend(title="Year", reverse=FALSE)) + theme_bw()
## 3. Close Connection
dev.off()