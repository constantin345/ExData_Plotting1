library(stringr)
library(dplyr)
library(lubridate)

#read the file
#using filter function from dplyr
#keep only the rows that have date "1/2/2007" or "2/2/2007"
#create a new column named dtime (combine Date and Time)
#create a new column named date_time (converting column dtime to  POSIXct)
df <- read.table(file="household_power_consumption.txt", 
                 sep=";", header=TRUE, 
                 stringsAsFactors=FALSE,
                 na.strings="?",
                 colClasses=c("character", "character", "numeric",
                              "numeric", "numeric", "numeric", 
                              "numeric", "numeric", "numeric")) %>%
  filter(Date =="1/2/2007" | Date =="2/2/2007") %>%
  mutate(dtime=str_c(Date, Time, sep=" ")) %>%
  mutate(date_time=dmy_hms(dtime))



##open png device
##create file plot3.png
png(width=480,height=480, filename="plot3.png")

#set values for xlab and ylab
xlab <- ""
ylab <- "Energy sub metering"


#draw a plot
with(df, plot(date_time, Sub_metering_1, type="n", xlab=xlab, ylab=ylab))

#add legend to previous plot
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=c(1,1,1), 
       col=c("black", "red", "blue")
       )

#add connected line segments to plot
with(df,lines(date_time, Sub_metering_1, type="l", col="black"))
with(df,lines(date_time, Sub_metering_2, type="l", col="red"))
with(df,lines(date_time, Sub_metering_3, type="l", col="blue"))

#close the png file
dev.off()