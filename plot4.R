## Read Files
## as long as each of those files is in your current working directory 
## check by calling dir() and see if those files are in the listing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subsetting coal related sources SCC values from SCC data
SCC_coal_data <- SCC[grep(pattern = "*coal* | *Coal*", SCC$Short.Name),]$SCC

## Subsetting coal data from NEI data
Coal_data <- NEI[NEI$SCC %in% SCC_coal_data,]

## Aggregating Coal Data by year
agg_Coal <- aggregate(x = Coal_data$Emissions, by = list(Coal_data$year), FUN = mean)

## Opening a png device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## Plotting US PM2.5 emissions from coal related sources using ggplot
g <- ggplot(data = agg_Coal, aes(x = as.factor(Group.1), y = x ))
g + geom_point(size = 3, alpha = 0.5) + geom_line(aes(group = 1)) + 
  labs(x= "Years", y = "Mean of PM2.5 Emissions", title = "US PM2.5 Emissions from Coal Sources")

## Closing graphic device
dev.off()