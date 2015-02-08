print("data.table package is required to run the analysis!!!")
library("data.table")

#read file 
myd<- fread("household_power_consumption.txt", header = TRUE, sep=";", na.strings ="?")

# update colclasses
myd$Date<-as.Date(myd$Date, "%d/%m/%Y")
myd$Global_active_power<-as.numeric(myd$Global_active_power)

usd<-myd[Date>="2007-02-01" & Date<="2007-02-02"]

# create subset with Global_active_power
pld<-usd[[3]]
# convert to the numeric vector
pld1<-as.numeric(pld)
#remove all the rows with missing data
pld2<-na.omit(pld1)

#build plot base
plot1<-hist(pld2,main ="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
dev.copy(png,filename="Plot1.png")
dev.off()
