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

##Chaning the Date/Time Format
Two_date_data$Date <- as.Date(Two_date_data$Date, format="%d/%m/%Y")
date_time <- paste(as.Date(Two_date_data$Date), Two_date_data$Time)
Two_date_data$Datetime <- as.POSIXct(date_time)

##Plotting the Graphs
png(filename = "plot4.png")
par(mfcol = c(2,2))

##Top Left
with(Two_date_data, {
        plot(Global_active_power~Datetime, type = "l", ylab = "Global Active Power",
             xlab = "")


##Bottom Left
        plot(Sub_metering_1~Datetime, type = "l", xlab = "", 
             ylab = "Energy sub metering")
        lines(Sub_metering_2~Datetime, col = "red")
        lines(Sub_metering_3~Datetime, col = "blue")
        legend("topright", lty=1, col=c("black","red","blue"),
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)

##Top Right
        plot(Voltage~Datetime, type = "l", ylab = "Voltage", xlab = "datetime")

##Bottom Right
        plot(Global_reactive_power~Datetime, type = "l", ylab = "Global_reactive_power", 
             xlab = "datetime")
})
dev.off()
