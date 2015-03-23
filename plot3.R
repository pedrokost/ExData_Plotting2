## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

data = subset(NEI, fips=='24510')
data$year <- factor(data$year)

emissions = aggregate(data[, c('Emissions')], by = list(data$year, data$type), FUN = sum)
names(emissions) <- c('year', 'type', 'emissions')

# IDEA: We are only intereseted in increase/decrease. Therefore we could normalize normalize the data, such that the sum in each group is zero

#qplot(emissions,	data = emissions,	facets	=	.	~	type, xlab=emissions$year)
g <- ggplot(data=emissions, aes(x=year, y=log(emissions), group=1))
g + geom_point() + facet_grid(. ~ type) + geom_smooth(method='lm') + xlab('Year') + ylab(expression('Log of ' * PM[2.5] * ' Emissions')) + ggtitle('Emissions per type in Baltimore city')

# ggplot(data = data, aes(x = year, y = log(Emissions))) +
#   facet_grid(. ~ type) +
#   guides(fill = F) +
#   geom_boxplot(aes(fill = type)) +
#   stat_boxplot(geom = 'errorbar') +
#   ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) +
#   xlab('Year') +
#   ggtitle('Emissions per Type in Baltimore City, Maryland') +
#   geom_jitter(alpha = 0.10)

# Save to a file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
