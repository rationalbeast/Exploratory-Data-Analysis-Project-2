## Read Files
## as long as each of those files is in your current working directory 
## check by calling dir() and see if those files are in the listing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Apply sum function to emmissions data using tapply segregating by year
ttl_emission <- tapply(NEI$Emissions, NEI$year, sum, na.rm = TRUE)

## Calling a graphic device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## Using base plot, plot the log10 values of total emmissions data for readable scale
plot(names(ttl_emission), log10(ttl_emission), xaxt = "n",type = "b", xlim = c(1998, 2008), xlab = "Years", ylab = "Log10(Total Emissions)", main = "US Total PM2.5 Emissions")
## Changing x axis values
axis(1, seq(1999,2008,3))

## Closing graphic device
dev.off()