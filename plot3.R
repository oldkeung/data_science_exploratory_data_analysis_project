library(dplyr)
library(ggplot2)

# Read Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Process Data

data <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize(totalEmissions = sum(Emissions))

# Generate Graph

png("plot3.png")

g <- ggplot(data, aes(year, totalEmissions, color = type))
g <- g + geom_line() +
	xlab("Year") +
    ylab("Total PM2.5 Emissions (ton)") +
    ggtitle('Total Emissions in Baltimore City, Maryland')
print(g)

dev.off()