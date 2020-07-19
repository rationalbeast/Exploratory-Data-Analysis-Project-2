## Read Files
## as long as each of those files is in your current working directory 
## check by calling dir() and see if those files are in the listing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting batimore city data, fips == 24510
balt_data <- subset(NEI, fips == "24510")

## subsetting motorcycle related sources SCC values from SCC data
veh_SCC <- SCC[grep("*Vehicle*",x = SCC$Short.Name),]$SCC

## Subsetting coal data from baltimore data
balt_veh <- balt_data[balt_data$SCC %in% veh_SCC,]

## Aggregating Emissions data for batimore city by year
balt_veh_agg <- aggregate(x = balt_veh$Emissions, by = list(balt_veh$year), FUN = mean)

## Opening a png device
png(filename = "plot5.png", width = 480, height = 480, units = "px")

## Plotting US PM2.5 emissions from motor vehicle related sources using ggplot
g <- ggplot(data = balt_veh_agg, aes(x = as.factor(Group.1), y = x ))
g + geom_point(size = 3, alpha = 0.5) + geom_line(aes(group = 1)) + 
  labs(x= "Years", y = "Mean of PM2.5 Emissions", title = "Baltimore PM2.5 Emissions from Motor Vehicles Sources")

## Closing graphic device
dev.off()