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

# Plot 1
if(!file.exists("Plots")) {dir.create("Plots")}
png(filename = "./Plots/plot2.png", width = 480, height = 480, units="px")

with(data, hist(Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red"))

dev.off()