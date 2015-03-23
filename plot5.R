## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
data = subset(NEI, fips=='24510' & type == 'ON-ROAD')

emissions = aggregate(data[, 'Emissions'], by = list(data$year), FUN = sum)
names(emissions) <- c('year', 'Emissions')
emissions <- transform(emissions, year=factor(year))
# x <- barplot(emissions[, 2], names.arg=emissions[,1], main='Emissions by coal combustion related sources by year', xlab="Year", ylab="Emissions of PM [tons]")
# text(x, 1, round(emissions[,2], 2))

# Save to a file
g <- ggplot(data = emissions, aes(x = year, y = Emissions))
g <- g + geom_bar(aes(fill = year), stat = "identity")
g <- g + guides(fill = F)  # Disables legend
g <- g + ggtitle('Emissions of Motor Vehicle Sources in Baltimore city') 
g <- g + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none')
g <- g + geom_text(aes(label = round(Emissions, 0), col=rgb(1,1,1), size = 1, hjust = 0.5, vjust = 2))
g <- g + scale_fill_manual(values=rep(rgb(0,0,0), length(unique(data$year)) ))
print(g)
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()
