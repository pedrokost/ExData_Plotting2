## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissions = aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)

barplot(emissions[, 2], names.arg=emissions[,1], main='PM25 by year', xlab="Year", ylab="Emissions of PM [tons]")

# Save to a file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
