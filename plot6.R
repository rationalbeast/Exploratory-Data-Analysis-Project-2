## Read Files
## as long as each of those files is in your current working directory 
## check by calling dir() and see if those files are in the listing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting batimore city & los angeles data, fips == 24510 & 06037
balt_los_data <- subset(NEI, fips == "24510" | fips == "06037")

## subsetting motorcycle related sources SCC values from SCC data
veh_SCC <- SCC[grep("*Vehicle*",x = SCC$Short.Name),]$SCC

## Subsetting coal data from baltimore & los angeles data 
balt_los_veh <- balt_los_data[balt_los_data$SCC %in% veh_SCC,]

## Aggregating Emissions data for batimore city and Los angeles by year
balt_los_veh_agg <- aggregate(x = balt_los_veh$Emissions, by = list(balt_los_veh$year, balt_los_veh$fips), FUN = mean)

names(balt_los_veh_agg)[2] <- "City"
balt_los_veh_agg$City <- rep(c("Los Angeles", "Baltimore"), each = 4)

## Opening a png device
png(filename = "plot6.png", width = 480, height = 480, units = "px")

## Plotting both cities PM2.5 emissions from motor vehicle related sources using ggplot
g <- ggplot(data = balt_los_veh_agg, aes(x = as.factor(Group.1), y = x, col = City ))
g + geom_point(size = 3, alpha = 0.5) + geom_line(aes(group = City)) + 
  labs(x= "Years", y = "Mean of PM2.5 Emissions", title = "Baltimore Vs Los Angeles PM2.5 Emissions from Motor Vehicles Sources")

## Closing graphic device
dev.off()