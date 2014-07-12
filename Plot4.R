#************************************************************************************************************
#                                       Exploratory Data Analysis Project 1
#
#       Our overall goal here is simply to examine how household energy usage varies over a 2-day period in 
#       February, 2007. Your task is to reconstruct the following plots below, all of which were constructed 
#       using the base plotting system.
#
#       **Loading the Data**
#               -We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#               -You may find it useful to convert the Date and Time variables to Date/Time classes in R 
#                  using the strptime() and as.Date() functions.
#               -Note that in this dataset missing values are coded as ?.
#
#       **Making Plots**
#       First you will need to fork and clone the following GitHub repository: 
#               https://github.com/rdpeng/ExData_Plotting1
#
#       For each plot you should
#       1.  Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#       2.  Name each of the plot files as plot1.png, plot2.png, etc.
#       3.  Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, 
#       i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the
#       data so that the plot can be fully reproduced. You should also include the code that creates the PNG file.
#       4.  Add the PNG file and R code file to your git repository
#************************************************************************************************************
#
#                                       Loading the Data
#       This same code will be found in each of the plot.R files
#
#************************************************************************************************************
#       Download the Zip file from UC Irvine Machine Learning Repository, unzip and extract household_power-consumption.txt
#
cat("\nDownload Data...")
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power_data.zip")
hshld.power.consump=read.table(unz("power_data.zip","household_power_consumption.txt"),sep=";",header=TRUE)
cat("completed.")
#
#       Convert the Date and Time variables using the as.Date() functions 
#               1.  modify the format to dd/mm/yyyy
#               2.  to only use the dates 2007-02-01 and 2007-02-02
#               3.  format the time to POSIXlt 
#              
cat("\nConvert Date Time Data...")
hshld.power.consump$Date=as.Date(hshld.power.consump$Date,format="%d/%m/%Y")
data=subset(hshld.power.consump, Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))
dtTm=paste(as.character(data$Date),as.character(data$Time),sep=" ")
fmt=strptime(dtTm,format="%Y-%m-%d %H:%M")
data$Time=fmt
cat("completed.")
#
#       Convert remainder variables from factor to numeric. 
#
cat("\nConvert to Numeric Data...")
for (i in 3:9)
{
        data[,i]=as.numeric(as.character(data[,i]))
}
cat("completed.")
#************************************************************************************************************
#
#       Plot 4:  Reconstruct 4 graphs that shows Global Active Power 
#                Graph 1.  Global Active Power Kilowatts per Thurs, Fri, Sat
#                Graph 2.  Global Active Power Voltage per datetime Thurs, Fri, Sat
#                Graph 3.  Global Active Power Energy Sub Metering per Thurs, Fri, Sat and color coded per sub meter
#                Graph 4.  Global Active Power Voltage Global Reactive Power per datetime Thurs, Fri, Sat
#
#************************************************************************************************************
cat("\nReconstructing Graph 4")
png("Plot4.png",bg="white")
par(mfrow=c(2,2))
plot(data$Time,data$Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xlab="")
plot(data$Time,data$Voltage,ylab="Voltage",type="l",xlab="datetime")
plot(data$Time,data$Sub_metering_1,ylab="Energy sub metering",type="l",xlab="")
plot.xy(xy.coords(data$Time,data$Sub_metering_2),type="l",col="red")
plot.xy(xy.coords(data$Time,data$Sub_metering_3),type="l",col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
plot(data$Time,data$Global_reactive_power,ylab="Global_reactive_power",type="l",xlab="datetime")
dev.off()
cat("completed.  Please look in your working directory for the Plot4.png file to see the graph")
