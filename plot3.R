# used library data.table to subset and read required data 
#following code from Alexey Burlutskiy- https://class.coursera.org/exdata-010/forum/thread?thread_id=20#comment-85
library(data.table)
dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),
                  units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread("household_power_consumption.txt", skip="1/2/2007", 
            nrows = rowsToRead, na.strings = c("?", ""))

#column names were picked by reading first line of data in conventional
# read.table() method
colum <- colnames(read.table("household_power_consumption.txt", 
                             header=T, sep= ";", nrows=1))
colnames(DT) <- colum
attach(DT) # attached to use column names as objects

#Date and Time converted to POSIXct using strptime()
datetime <- paste(Date, Time)
datetime <- as.POSIXct(strptime(datetime, "%d/%m/%Y %H:%M:%S"))

# line graph of days vs Global active power developed to png() device
png(file="plot3.png", height=480, width = 480)
plot(datetime, Sub_metering_1, type="n", xlab= "", ylab= "Energy sub metering")
lines(datetime, Sub_metering_1)
lines(datetime, Sub_metering_2, col="red")
lines(datetime, Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1)
dev.off()
