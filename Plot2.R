print("data.table package is required to run the analysis!!!")
library("data.table")

#read file 
myd<- fread("household_power_consumption.txt", header = TRUE, sep=";", na.strings ="?")

# update colclasses
myd$Date<-as.Date(myd$Date, "%d/%m/%Y")
myd$Global_active_power<-as.numeric(myd$Global_active_power)

usd<-myd[Date>="2007-02-01" & Date<="2007-02-02"]

#remove rows with missing values
pld<-na.omit(usd)

#create x axis
datetime<-as.POSIXct(paste(pld$Date, pld$Time),
                     format="%Y-%m-%d %H:%M:%S")

#create y axis
gap<-pld[[3]]

#build plot base
plot(datetime,gap,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png,filename="Plot2.png")
dev.off()
