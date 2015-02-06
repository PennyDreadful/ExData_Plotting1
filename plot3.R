library(R.utils)
downloadFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", method = "curl", file = "PowerConsumption.zip")
unzip("PowerConsumption.zip")

power.head <- read.table("household_power_consumption.txt", header = TRUE, sep = ";" ,nrows = 5, na.strings = "?")
power.head
classes <- sapply(power.head, class)
dt <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?")
dt$Date <- strptime(dt$Date, format = "%d/%m/%Y")

start.date <- strptime("2007-02-01", format = "%Y-%m-%d") 
end.date <- strptime("2007-02-02", format = "%Y-%m-%d")

dt.interval <- dt[dt$Date >= start.date & dt$Date <= end.date,]
dt.interval$FormattedTime <- mapply(paste, as.Date(dt.interval$Date), dt.interval$Time)
dt.interval$FormattedTime <- as.POSIXct(strptime(dt.interval$FormattedTime, format = "%Y-%m-%d %H:%M:%S"))

png("plot3.png")

plot(Sub_metering_1 ~ FormattedTime, data = dt.interval, ylab = "Energy sub metering", type = "n", xlab = "")

lines(Sub_metering_1 ~ FormattedTime, data = dt.interval)
lines(Sub_metering_2 ~ FormattedTime, data = dt.interval, col = "red")
lines(Sub_metering_3 ~ FormattedTime, data = dt.interval, col = "blue")

legend("topright", lwd = "1", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()