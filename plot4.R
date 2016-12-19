# The following script downloads data, organizes it into a data frame, 
# creates a PNG file device and constructs a plot in that file.

# Download the data file and unzip the file into a folder.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exdata_data_household_power_consumption.zip", mode = "wb")
unzip("./exdata_data_household_power_consumption.zip", exdir = ".")

# Read relevant data set into R
data <- read.table("./household_power_consumption.txt", sep=";", 
                   header = TRUE, na.strings = "?")

# Subset and merge data
dataA <- subset(data,Date=="1/2/2007")
dataB <- subset(data,Date=="2/2/2007")
dataC <- rbind(dataA,dataB)

# Convert Dates and Times and organize data
Date2 <- as.Date(dataC$Date, "%d/%m/%Y")
Time2 <- strptime(dataC$Time, format="%T")
Time2 <- strftime(Time2, "%T")
DateTime <- strptime(paste(Date2, Time2), format="%Y-%m-%d %H:%M:%S")
DayOfWeek <- strftime(DateTime, format="%a")
data2 <- cbind(DateTime, Date2, Time2, DayOfWeek, dataC[,c(3,4,5,6,7,8,9)])

# Create PNG file device
png(filename="plot4.png", width=480, height=480, bg="transparent")

# Create plot with 2by2 array of 4 figures
par(mfrow = c(2,2))

plot(data2$Global_active_power ~ data2$DateTime,xlab="",
     ylab="Global Active Power",pch=NA)
    lines(data2$Global_active_power ~ data2$DateTime)

plot(data2$Voltage ~ data2$DateTime,xlab="datetime",
     ylab="Voltage",pch=NA)
    lines(data2$Voltage ~ data2$DateTime)

plot(data2$Sub_metering_1 ~ data2$DateTime,pch=NA,xlab="",
     ylab="Energy sub metering")
    lines(data2$Sub_metering_1 ~ data2$DateTime)
    lines(data2$Sub_metering_2 ~ data2$DateTime, col="red")
    lines(data2$Sub_metering_3 ~ data2$DateTime, col="blue")
    legend("topright",col=c("black","blue","red"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty="solid",bty="n")

plot(data2$Global_reactive_power ~ data2$DateTime,xlab="datetime",
     ylab="Global_reactive_power",pch=NA)
    lines(data2$Global_reactive_power ~ data2$DateTime)

# Close PNG file device
dev.off()
