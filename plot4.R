if(!file.exists("data")) { ## checking if the data directory exists if not - then creating it
        dir.create("data")
}
##downloading the dataset [START]

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileURL,destfile="./data/energy_consumption.zip")
##downloading the dataset [END]
unzip("./data/energy_consumption.zip",exdir="./data/ExData_Plotting1") ##extracting the dataset from zipfile 

##downloading the dataset [END]

## getting the classes of the data [START]
tab2rows <- read.table("./data/ExData_Plotting1/household_power_consumption.txt", header = TRUE, nrows = 2,sep =";", stringsAsFactors = F) 
classes <- sapply(tab2rows, class)

## getting the classes of the data [END]

EnergyData<-read.table(pipe('grep "^[1-2]/2/2007" "./data/ExData_Plotting1/household_power_consumption.txt"'), sep =";", na.strings = "?", colClasses = classes) ##getting the data into a data.frame with the necessary dates
colnames(EnergyData) <-names(read.table('./data/ExData_Plotting1/household_power_consumption.txt', header=TRUE,sep=";",nrows=1)) ## assigning column names

EnergyData$Date<-as.Date(EnergyData$Date,"%d/%m/%Y") ## converting the Date column into Date format
EnergyData$DateTime<-paste(EnergyData$Date,EnergyData$Time) ##combining Date and Time into one column
EnergyData$DateTime<-strptime(EnergyData$DateTime,"%Y-%m-%d %H:%M:%S") ## converting the DateTime column into Date and time format

parmf<-par("mfcol") ## storing the original setting for mfcol parameter
lct <- Sys.getlocale("LC_TIME") ## storing the regional Time settings into a variable
Sys.setlocale("LC_TIME", "C")## turning the regional Time settings off for plotting

## saving the plot into a PNG file [START]
png(file = "./data/ExData_Plotting1/plot4.png", units = "px", width = 480, height = 480) 

par(mfcol=c(2,2)) ## setting the mfcol for the 2 by 2 graph

##plotting topleft graph [START]
plot(EnergyData$DateTime,EnergyData$Global_active_power, xlab="", ylab = "Global Active Power", type = "l") 
##plotting topleft graph [END]


##plotting bottomleft graph [START]

plot(EnergyData$DateTime,EnergyData$Sub_metering_1, xlab="", ylab = "Energy sub metering", type = "n") ##plotting the empty graph

points(EnergyData$DateTime,EnergyData$Sub_metering_1, type = "l") ##plotting the graph for the Sub_metering_1
points(EnergyData$DateTime,EnergyData$Sub_metering_2, type = "l", col = "red") ##plotting the graph for the Sub_metering_2
points(EnergyData$DateTime,EnergyData$Sub_metering_3, type = "l", col = "blue") ##plotting the graph for the Sub_metering_3


legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, box.lty = 0, inset = 0.01) ## adding a legend 
##plotting bottomleft graph [END]

##plotting topright graph [START]

plot(EnergyData$DateTime,EnergyData$Voltage, xlab="datetime", ylab = "Voltage", type = "l") 

##plotting topright graph [END]

##plotting bottomright graph [START]

plot(EnergyData$DateTime,EnergyData$Global_reactive_power, xlab="datetime", ylab = "Global_reactive_power", type = "l") 

##plotting bottomright graph [END]
dev.off()

## saving the plot into a PNG file [END]
par(mfcol = parmf) ## setting the mfcol setting back to the original
Sys.setlocale("LC_TIME", lct) ## setting the regional Time settings back to the original
