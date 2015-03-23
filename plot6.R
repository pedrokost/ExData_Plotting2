## Compare emissions from motor vehicle sources in Baltimore City with emissions from
## motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
NEI2=NEI

BalitimoreFIP = '24510'
LACountyFIP = '06037'
numfips = c(BalitimoreFIP, LACountyFIP)
namefips = c('Baltimore City', 'Los Angeles County')
NEI = subset(NEI2, (fips %in% numfips) & type == 'ON-ROAD')

for(i in seq_along(fips)) {
  NEI$fips[NEI$fips==numfips[i]] = namefips[i] 
}

data = NEI

emissions = aggregate(data[, 'Emissions'], by = list(data$year, data$fips), FUN = sum)
names(emissions) <- c('year', 'location', 'Emissions')
emissions <- transform(emissions, year=factor(year))

# Save to a file
g <- ggplot(data = emissions, aes(x = year, y = Emissions, group=1));
g <- g + facet_grid(. ~ location);
g <- g + geom_bar(aes(fill = year), stat = "identity");
g <- g + stat_smooth(method='lm', se=FALSE); 
g <- g + guides(fill = F); # Disables legend
g <- g + ggtitle('Emissions of Motor Vehicle Sources in Baltimore city') ; 
g <- g + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none'); 
g <- g + geom_text(aes(label = round(Emissions, 0), col=rgb(1,1,1), size = 1, hjust = 0.5, vjust = -1));
g <- g + scale_fill_manual(values=rep(rgb(0,0,0), length(unique(data$year)) ));
print(g)

dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()
