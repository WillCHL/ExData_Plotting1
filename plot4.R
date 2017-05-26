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


## Plot 4 ##

# Set-up png
png("plot4.png", width=480, height=480)

  # Set plot area
  par(mfrow=c(2,2))
    
    # Sub plot 1 - Global Active Power ~ Time
    with(powerDF, 
         plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    )
  
    # Sub plot 2 - Voltage ~ Time
    with(powerDF, 
         plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime")
    )
  
    # Set-up legend names for plot 3
    legtxt <- names(powerDF)[grep("Sub_", names(powerDF))]
  
    # Sub plot 3 of sub_metering
    with(powerDF, {
      plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
      lines(DateTime, Sub_metering_2, col="red")
      lines(DateTime, Sub_metering_3, col="blue")
      legend("topright", legend=legtxt, lty = 1, col=c("black","red","blue"), bty = "n")
    })
    
    # Sub plot 4 - Global Reactive Power ~ Time
    with(powerDF, 
         plot(DateTime, Global_reactive_power, type="l", xlab="datetime")
    )
    
dev.off()
