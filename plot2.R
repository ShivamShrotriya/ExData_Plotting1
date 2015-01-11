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
png(file="plot2.png", height=480, width = 480)
plot(datetime, Global_active_power, type="l", xlab= "", ylab= "Global Active Power (kilowatt)")
dev.off()