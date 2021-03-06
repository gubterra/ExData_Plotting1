mydf <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,  stringsAsFactors = FALSE)

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


## Converting dates
datetime <- paste(as.Date(mydfsub$Date), mydfsub$Time)
mydfsub$Datetime <- as.POSIXct(datetime)


## plot 1
hist(mydfsub$Global_active_power, xlab = "Global Active Power (kilowatts)", col ="red", main = "Global Active Power")

## plot 2
plot(mydfsub$Datetime, mydfsub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(mydfsub$Datetime, mydfsub$Sub_metering_1,  type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Plot 3
with(mydfsub, {
  plot(Sub_metering_1~Datetime,  type="l", xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(mydfsub, {
  plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="Datetime")
  plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
 
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o") 
  plot(Global_reactive_power~Datetime, type="l", ylab="Global Reactive Power (kilowatts)",xlab="Datetime")
})