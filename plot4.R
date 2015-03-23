# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
# Samples data for testing

SCC.Coal <- SCC[grepl('coal', SCC$Short.Name, ignore.case=T), ]
# Merges the data
data <- merge(x = NEI, y = SCC.Coal, by = c('SCC'))

emissions = aggregate(data[, 'Emissions'], by = list(data$year), FUN = sum)

x <- barplot(emissions[, 2], names.arg=emissions[,1], main='Emissions by coal combustion related sources by year', xlab="Year", ylab="Emissions of PM [tons]")
text(x, 30000, round(emissions[,2], 2))

# Save to a file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
