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
png("plot4.png", width = 480, height = 480, units = "px")

#setup multiplot image
par(mfrow = c(2,2), mar = c(4,4,2,1))

with(datasub2, {
        #plot 1 - global active power v time
        par(pch = ".")
        plot(datasub2$datetime, datasub2$Global_active_power, 
             ylab = "Global Active Power (kilowatts)",
             xlab = "")
        lines(datasub2$datetime, datasub2$Global_active_power)
        
        #plot 2 - voltage v time
        plot(datasub2$datetime, datasub2$Voltage, 
             ylab = "Voltage",
             xlab = "datetime")
        lines(datasub2$datetime, datasub2$Voltage)

        
        #plot 3 - energy sub metering v time
        plot(datasub2$datetime, datasub2$Sub_metering_1, type = 'n',
             ylab = "Energy sub metering",
             xlab = "")
        
        lines(datasub2$datetime, datasub2$Sub_metering_1, col = "black")
        lines(datasub2$datetime, datasub2$Sub_metering_2, col = "red")
        lines(datasub2$datetime, datasub2$Sub_metering_3, col = "blue")
        
        legend("topright", lty = 1, col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        #plot 4 - global reactive power v time
        plot(datasub2$datetime, datasub2$Global_reactive_power, 
             ylab = "Global_reactive_power",
             xlab = "datetime")
        lines(datasub2$datetime, datasub2$Global_reactive_power)
                
})

dev.off()