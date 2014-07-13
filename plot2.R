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
EnergyDataIn<-read.table("./data/ExData_Plotting1/household_power_consumption.txt", header = T, sep =";", na.strings = "?", colClasses = classes, blank.lines.skip = FALSE) ##getting the data into an Initital data frame
EnergyDataIn$Date<-as.Date(EnergyDataIn$Date,"%d/%m/%Y") ## converting the Date column into Date format
EnergyData<-subset(EnergyDataIn, Date >= "2007-02-01"&Date <= "2007-02-02") ## subsetting only the dates necessairy
EnergyData$DateTime<-paste(EnergyData$Date,EnergyData$Time) ##combining Date and Time into one column
EnergyData$DateTime<-strptime(EnergyData$DateTime,"%Y-%m-%d %H:%M:%S") ## converting the DateTime column into Date and time format

lct <- Sys.getlocale("LC_TIME") ## storing the regional Time settings into a variable
Sys.setlocale("LC_TIME", "C")## turning the regional Time settings off for plotting

## saving the plot into a PNG file [START]
png(file = "./data/ExData_Plotting1/plot2.png", units = "px", width = 480, height = 480) 
plot(EnergyData$DateTime,EnergyData$Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", type = "l") ##plotting the graph
dev.off()
## saving the plot into a PNG file [END]
Sys.setlocale("LC_TIME", lct) ## setting the regional Time settings back  to the original