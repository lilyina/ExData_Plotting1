#download files
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#the directory for data
path<-"Data"
#the name of zip fike
zip<-"exdata%2Fdata%2Fhousehold_power_consumption.zip"
#the name for unziped data 
dest<-paste(path,zip,sep="//")

file<-"household_power_consumption.txt"
if (!file.exists(path)) {
	dir.create(path)
}
download.file(url,dest,mode="wb")

#unzip zip file containing data if data file doesn't already exist
if (!file.exists(file)) {
	unzip(dest)
}

#read need data from file
# 66638 the first row with '1/2/2007' in data column
# 69517 the last row with '2/2/2007' in data column

nrow<-69517 - 66638 + 1 
f<-read.table("household_power_consumption.txt", skip = 66636,nrow = nrow, sep=";", header = TRUE)
#read header to h

h<-read.table("household_power_consumption.txt",nrow = 1,sep=";",header = TRUE)
colnames(f)<-colnames(h)

#read data from then column  Global_active_power to vector
x<-f$"Global_active_power"

#built histogram
hist(x,xlab="Global active power (kilowatts)", main = "Global Active Power", col = "red")

#save to png file
dev.copy(png,"Plot1.png")
png("Plot1.png",width = 480, height = 480)
dev.off()