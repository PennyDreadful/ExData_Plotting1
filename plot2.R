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

png("plot2.png")

plot(Global_active_power ~ FormattedTime, data = dt.interval, ylab = "Global Active Power (kilowatts)", type = "l", xlab = "")

dev.off()