# The following script downloads data, organizes it into a data frame, 
# creates a PNG file device and constructs a plot in that file.

# Download the data file and unzip the file into a folder.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exdata_data_household_power_consumption.zip", mode = "wb")
unzip("./exdata_data_household_power_consumption.zip", exdir = ".")

# Read relevant data set into R
data <- read.table("./household_power_consumption.txt", sep=";", 
                   header = TRUE, na.strings = "?")
# Subset data
data <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]

# Convert Dates and Times and organize data
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strftime(strptime(data$Time,format="%T"), "%T")
DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
DayOfWeek <- strftime(DateTime, format="%a")
data2 <- cbind(DateTime, data$Date, data$Time, DayOfWeek, data[,c(3,4,5,6,7,8,9)])

# Create PNG file device
png(filename="plot3.png", width=480, height=480)

# Create plot
plot(data2$Sub_metering_1 ~ data2$DateTime,pch=NA,xlab="",
     ylab="Energy sub metering")
    lines(data2$Sub_metering_1 ~ data2$DateTime)
    lines(data2$Sub_metering_2 ~ data2$DateTime, col="red")
    lines(data2$Sub_metering_3 ~ data2$DateTime, col="blue")
    legend("topright",col=c("black","blue","red"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty="solid")

# Close PNG file device
dev.off()
