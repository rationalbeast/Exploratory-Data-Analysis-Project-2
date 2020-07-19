## Read Files
## as long as each of those files is in your current working directory 
## check by calling dir() and see if those files are in the listing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting batimore city data, fips == 24510
balt_data <- subset(NEI, fips == "24510")

## Apply sum function to emmissions data using tapply segregating by year
ttl_emission <- tapply(balt_data$Emissions, balt_data$year, sum, na.rm = TRUE)

## Calling a graphic device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

## Using base plot, plot the values of total emmissions data
plot(names(ttl_emission), ttl_emission, xaxt = "n",type = "b", xlim = c(1998, 2008), xlab = "Years", ylab = "Total Emissions")
title(main = "Baltimore City, Maryland - PM2.5 Emmissions")
axis(1, seq(1999, 2008, 3))

## Closing graphic device
dev.off()