# Reading, naming and subsetting power consumption data
power_data <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power_data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
power_subdata <- subset(power_data,power_data$Date=="1/2/2007" | power_data$Date =="2/2/2007")

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
power_subdata$Date <- as.Date(power_subdata$Date, format="%d/%m/%Y")
power_subdata$Time <- strptime(power_subdata$Time, format="%H:%M:%S")
power_subdata[1:1440,"Time"] <- format(power_subdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
power_subdata[1441:2880,"Time"] <- format(power_subdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# calling the basic plot functions
plot(power_subdata$Time,power_subdata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(power_subdata,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(power_subdata,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(power_subdata,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# annotating graph
title(main="Energy sub-metering")