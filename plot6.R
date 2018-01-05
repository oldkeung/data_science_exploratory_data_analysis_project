library(dplyr)
library(ggplot2)

# Read Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Process Data

data <- inner_join(filter(NEI, fips %in% c("24510", "06037")), filter(SCC, grepl("vehicle", EI.Sector, ignore.case = TRUE)), by = "SCC") %>% group_by(fips, year) %>% summarize(totalEmissions = sum(Emissions))

data$city[data$fips == "24510"] <- "Baltimore City"
data$city[data$fips == "06037"] <- "Los Angeles"

# Generate Graph

png("plot6.png", width=640, height=480)

g <- ggplot(data, aes(factor(year), totalEmissions))
g <- g + facet_grid(. ~ city)
g <- g + geom_bar(stat = "identity") +
  geom_smooth(aes(factor(year), totalEmissions, group = 1), method = "lm", se = FALSE) +
  xlab("Year") +
  ylab("Total PM2.5 Emissions (ton)") +
  ggtitle('Total Emissions from Motor Vehicle in Baltimore City, Maryland vs Los Angeles, California')
print(g)

dev.off()