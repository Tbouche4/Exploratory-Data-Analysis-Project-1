##Download File
if(!file.exists("./EPC data")){dir.create("./EPC data")}
fileurl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./EPC data/data.zip")
unzip("./EPC data/data.zip", exdir = "./EPC data")

##Read in rows of the two days 2007-02-01 and 2007-02-02
EPC_data<- read.table("./EPC data/household_power_consumption.txt", 
                      sep = ";", na.strings = "?", skip = 1)
colnames(EPC_data)<- c("Date","Time","Global_active_power",
                       "Global_reactive_power","Voltage","Global_intensity",
                       "Sub_metering_1","Sub_metering_2","Sub_metering_3")
Two_date_data<- subset(EPC_data, EPC_data$Date == "1/2/2007" | 
                               EPC_data$Date == "2/2/2007")

##Making the Histogram
png(filename = "plot1.png")
hist(Two_date_data$Global_active_power, main = "Global Active Power", 
     col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()
