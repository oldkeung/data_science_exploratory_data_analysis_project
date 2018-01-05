library(dplyr)
library(ggplot2)

# Read Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Process Data

data <- inner_join(filter(NEI, fips == "24510"), filter(SCC, grepl("vehicle", EI.Sector, ignore.case = TRUE)), by = "SCC") %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# Generate Graph

png("plot5.png")

g <- ggplot(data, aes(factor(year), totalEmissions))
g <- g + geom_bar(stat = "identity") +
	xlab("Year") +
	ylab("Total PM2.5 Emissions (ton)") +
	ggtitle('Total Emissions from Motor Vehicle Sources in Baltimore City, Maryland')
print(g)

dev.off()