
setwd("C:/Users/Gu-Work/Desktop/repos/ExData_Plotting1")

mydf <- read.csv("../ExData_Plotting1/household_power_consumption.txt", header=T, sep=';',
                na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

mydf$Date <- strptime(mydf$Date, "%d/%m/%Y")
mydf$Date <- as.Date(mydf$Date)

mydfsub <- subset(mydf, Date >= "2007-02-01" & Date <= "2007-02-02")

mydfsub$Voltage <- as.numeric(mydfsub$Voltage)
mydfsub$Global_active_power <- as.numeric(mydfsub$Global_active_power)
mydfsub$Global_reactive_power <- as.numeric(mydfsub$Global_reactive_power)
mydfsub$Global_intensity <- as.numeric(mydfsub$Global_intensity)
mydfsub$Sub_metering_1 <- as.numeric(mydfsub$Sub_metering_1)
mydfsub$Sub_metering_2 <- as.numeric(mydfsub$Sub_metering_2)
mydfsub$Sub_metering_3 <- as.numeric(mydfsub$Sub_metering_3)

## casting dates
datetime <- paste(as.Date(mydfsub$Date), mydfsub$Time)
mydfsub$Datetime <- as.POSIXct(datetime)

## Plot 3
with(mydfsub, {
  plot(Sub_metering_1~Datetime,  type="l", xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o") 
})

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
