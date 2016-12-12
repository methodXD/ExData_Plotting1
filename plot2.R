# The following script downloads data and constructs a plot.

# Downloads the data files and unzip the files into a folder.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exdata_data_household_power_consumption.zip", mode = "wb")
unzip("./exdata_data_household_power_consumption.zip", exdir = ".")

# Read relevant data sets into R
data <- read.table("./household_power_consumption.txt", sep=";", 
                   header = TRUE, na.strings = "?")

#Subset Data
dataA <- subset(data,Date=="1/2/2007")
dataB <- subset(data,Date=="2/2/2007")
dataC <- rbind(dataA,dataB)

#Convert Dates and Times and organize data
Date2 <- as.Date(dataC$Date, "%d/%m/%Y")
Time2 <- strptime(dataC$Time, format="%T")
Time2 <- strftime(Time2, "%T")
DateTime <- strptime(paste(Date2, Time2), format="%Y-%m-%d %H:%M:%S")
DayOfWeek <- strftime(DateTime, format="%a")
data2 <- dataC[,c(3,4,5,6,7,8,9)]
data3 <- cbind(DateTime, Date2, Time2, DayOfWeek, data2)

#create PNG file device
png(filename="plot2.png", width=480, height=480, bg="white")

#Create plot
plot(data3$Global_active_power ~ data3$DateTime,xlab="",
    ylab="Global Active Power (kilowatts)",pch=NA)
    lines(data3$Global_active_power ~ data3$DateTime)

#Close PNG file device
dev.off()
