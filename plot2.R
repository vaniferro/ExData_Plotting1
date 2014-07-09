#import data
file <- "./household_power_consumption.txt"
data <- read.table(file = file, header = TRUE, sep = ";", 
                    na.strings = "?")

#clean and subset data according to date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subdate <- subset(data, as.Date(Date) == "2007-02-01" |
                          as.Date(Date) == "2007-02-02")

#convert to date/time column
datetime <- paste(subdate[,1], subdate[,2], sep = " ")
datetime <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S")
datasub2 <- data.frame(datetime, subdate[3:9])

#create and export plot
png("plot2.png", width = 480, height = 480, units = "px")

par(pch = ".")
plot(datasub2$datetime, datasub2$Global_active_power, 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
lines(datasub2$datetime, datasub2$Global_active_power)

dev.off()