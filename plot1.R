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
png("plot1.png", width = 480, height = 480, units = "px")
hist(datasub2$Global_active_power, col = "red", 
     axes = F,
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
axis(1, at = c(0,2,4,6), labels = c("0","2","4","6"))
axis(2, at = c(0,200,400,600,800,1000,1200), 
     labels = c("0","200","400","600","800","1000","1200"))
dev.off()