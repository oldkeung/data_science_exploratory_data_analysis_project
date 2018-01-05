library(dplyr)
library(ggplot2)

# Read Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Process Data

data <- inner_join(NEI, filter(SCC, grepl("coal", Short.Name, ignore.case = TRUE)) %>% filter(grepl("comb", EI.Sector, ignore.case = TRUE)), by = "SCC") %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# Generate Graph

png("plot4.png")

g <- ggplot(data, aes(factor(year), totalEmissions))
g <- g + geom_bar(stat = "identity") +
	xlab("Year") +
	ylab("Total PM2.5 Emissions (ton)") +
	ggtitle('Total Emissions from Coal Combustion-Related Sources in United States')
print(g)

dev.off()