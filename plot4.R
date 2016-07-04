# set working directory and load R packages needed
setwd("D:/YY/Coursera/4. Exploratory Data Analysis/week 1")
library(data.table)

# download zip file
if(!file.exists('data')) {dir.create('data')}
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./data/household_power_consumption.zip")

# unzip file and read data
unzip("./data/household_power_consumption.zip", exdir="./data")
txtfile <- "./data/household_power_consumption.txt"
Feb <- grep("^[1,2]/2/2007", readLines(txtfile))
skip <- Feb[1]-1
nrows <- length(Feb)
data <- fread(txtfile, skip = skip, nrows = nrows, header = FALSE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.string = "?")

# Plot 4
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$DateTime <- as.POSIXct(with(data, paste(Date,Time)))
if(!file.exists("Plots")) {dir.create("Plots")}
png(filename = "./Plots/plot4.png", width = 480, height = 480, units="px")
par(mfrow=c(2,2))
# plot(1,1)
plot(data$DateTime, data$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatt)", type = "l")
# plot(1,2)
with(data,plot(DateTime, Voltage, xlab = "datetime", type = "l"))
# plot(2,1)
plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_netering_3"))
# plot(2,2)
with(data,plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l"))
# close device
dev.off()

