library(dplyr)

# Read Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Process Data

data <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# Generate Graph

png("plot2.png")

barplot(height = data$totalEmissions, names.arg = data$year, xlab = "Year", ylab='Total PM2.5 Emissions (ton)', main = 'Total PM2.5 Emissions in Baltimore City, Maryland')

dev.off()