#download files
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#the directory for data
path<-"Data"
#the name of zip file
zip<-"exdata%2Fdata%2Fhousehold_power_consumption.zip"
#the name for unziped data 
dest<-paste(path,zip,sep="//")
#the name for unzip file
file<-"household_power_consumption.txt"

if (!file.exists(file)) {

	if (!file.exists(path)) {
		dir.create(path)
	}
	download.file(url,dest,mode="wb")

	#unzip zip file containing data if data file doesn't already exist
	unzip(dest)
}

#read need data from file
# 66638 the first row with '1/2/2007' in Date column
# 69517 the last row with '2/2/2007' in Date column

nrow<-69517 - 66638 + 1 
f<-read.table("household_power_consumption.txt", skip = 66636, nrow = nrow, sep=";", header = TRUE)
#read header to h

h<-read.table("household_power_consumption.txt",nrow = 1,sep=";",header = TRUE)
colnames(f)<-colnames(h)

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
f$Time <- strptime(paste(f$Date,f$Time), format="%d/%m/%Y %H:%M:%S")
f$Date <- as.Date(f$Date, format="%d/%m/%Y")

# calling the basic plot functions
plot(f$Time,f$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(f,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(f,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(f,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
#add legend
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#add title
title(main="Energy sub-metering")
#copy and save to png file 
dev.copy(png,"Plot3.png")
dev.off()