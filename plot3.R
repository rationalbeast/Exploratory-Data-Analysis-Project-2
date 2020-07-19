## Read Files
## as long as each of those files is in your current working directory 
## check by calling dir() and see if those files are in the listing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting batimore city data, fips == 24510
balt_data <- subset(NEI, fips == "24510")

## Aggregating Emissions data for batimore city by type and year
Balt_groups <- aggregate(x = balt_data$Emissions, by = list(balt_data$type, balt_data$year), FUN = mean)

## Opening a png device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

## Creating a plot using ggplot
g <- ggplot(data = Balt_groups, aes(y = x, x = as.factor(Group.2)))

## Adding geometrical annotations, labels, changing x-axis values
g + geom_point(aes(col = factor(Group.1)), size = 3) + 
  geom_line(aes(group = Group.1, col = Group.1)) + 
  labs(x= "Years", y = "Mean of PM2.5 Emissions", title = "Baltimore City PM2.5 Emissions | Emissions ~ Type") +
  scale_x_discrete(breaks = c("1999", "2002", "2005", "2008"), labels = c("1999", "2002", "2005", "2008"))

## Closing graphic device
dev.off()