## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# NEI = NEI[sample(nrow(NEI), size = 1000, replace = F), ]

data = subset(NEI, fips=='24510')
emissions = aggregate(data[, 'Emissions'], by = list(data$year), FUN = sum)
barplot(emissions[, 2], names.arg=emissions[,1], main='PM25 by year in Baltimore City', xlab="Year", ylab="Emissions of PM [tons]")

# Save to a file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
