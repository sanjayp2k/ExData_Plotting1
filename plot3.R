## This script loads the data from the "Individual household electric power consumption Data Set".
## And then we would be plotting graphs using data from the dates 2007-02-01 and 2007-02-02


## Load the "Individual household electric power consumption Data Set"
powerConsumptionData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses=c("character", "character", rep("numeric", 7)), na.strings="?")


## Converting the date column to Date class:
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, format="%d/%m/%Y")

## Subsetting the data.frame to only include the desired dates:
subsetPowerConsumptionData <- powerConsumptionData[powerConsumptionData$Date >= as.Date("2007-02-01") & powerConsumptionData$Date<=as.Date("2007-02-02"),]

## Converting Date and Time columns to be used for the plot
subsetPowerConsumptionData$Date <- strptime(paste(subsetPowerConsumptionData$Date, subsetPowerConsumptionData$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S")

## Construct the plot and save it to a PNG file

## open PNG file (plot3.png) with a width of 480 pixels and a height of 480 pixels in my working directory
png( filename="plot3.png", width = 480, height = 480)

## get the y axis max value
yAxisMaxValue <- max(subsetPowerConsumptionData$Sub_metering_1, subsetPowerConsumptionData$Sub_metering_2, subsetPowerConsumptionData$Sub_metering_3)

## plot line graph for "Global Active Power" variable and send to file
## set the labels
plot(subsetPowerConsumptionData$Date, subsetPowerConsumptionData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", ylim=c (0, yAxisMaxValue) )
lines(subsetPowerConsumptionData$Date, subsetPowerConsumptionData$Sub_metering_1, col="black")
lines(subsetPowerConsumptionData$Date, subsetPowerConsumptionData$Sub_metering_2, col="red")
lines(subsetPowerConsumptionData$Date, subsetPowerConsumptionData$Sub_metering_3, col="blue")
## set legends
legend("topright", col=c("black", "blue", "red"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), lwd=1)

## Close the graphic device
dev.off()

