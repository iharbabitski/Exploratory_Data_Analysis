print("data.table package is required to run the analysis!!!")
library("data.table")

#read file 
myd<- fread("household_power_consumption.txt", header = TRUE, sep=";", na.strings ="?")

# update colclasses
myd$Date<-as.Date(myd$Date, "%d/%m/%Y")
myd$Sub_metering_1<-as.numeric(myd$Sub_metering_1)
myd$Sub_metering_2<-as.numeric(myd$Sub_metering_2)
myd$Sub_metering_3<-as.numeric(myd$Sub_metering_3)

usd<-myd[Date>="2007-02-01" & Date<="2007-02-02"]

#remove rows with missing values
pld<-na.omit(usd)

#create x axis
datetime<-as.POSIXct(paste(pld$Date, pld$Time),
                     format="%Y-%m-%d %H:%M:%S")

#create y axis
Sub_metering_1<-pld[[7]]
Sub_metering_2<-pld[[8]]
Sub_metering_3<-pld[[9]]

#build plot base
plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(datetime,Sub_metering_2,type="l",col="red")
lines(datetime,Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "),
                           lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"),cex=0.7)
dev.copy(png,filename="Plot3.png")
dev.off()
