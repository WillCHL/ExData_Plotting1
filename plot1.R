## R script for creating plots from Electric power consumption data for Exploratory Data Analysis course.

# Download data if required
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              "power.zip", method= "curl")
unzip("power.zip")

# Read data if required
colclass <- c(rep("character",2),rep("numeric",7))
powerDF <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                      colClasses=colclass, na.strings = "?")

# Format data
powerDF$Date <- as.Date(powerDF$Date, format="%d/%m/%Y")
powerDF <- subset(powerDF, Date>="2007-02-01" & Date<="2007-02-02")
powerDF$DateTime <- as.POSIXlt(paste(powerDF$Date, powerDF$Time), format="%Y-%m-%d %H:%M:%S")
powerDF$Time <- strptime(powerDF$Time, format="%H:%M:%S")


## Plot 1 ##

# Set plot area
par(mfrow=c(1,1))

# Plot 1 - histogram Global Active Power to png
png("plot1.png", width=480, height=480)
  hist(powerDF$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
