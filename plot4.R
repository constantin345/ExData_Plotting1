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
##create file plot4.png
png(width=480,height=480, filename="plot4.png")

#create a matrix of 2x2 plots that are filled in by row
par(mfrow=c(2,2))

#set values for xlab and ylab
xlab <- ""
ylab <- "Global Active Power"


#draw the first plot
with(df, plot(date_time, Global_active_power, type="n", xlab=xlab, ylab=ylab))
with(df,lines(date_time, Global_active_power, type="l"))

#set values for xlab and ylab
xlab <- "datetime"
ylab <- "Voltage"

#draw the second plot
with(df, plot(date_time, Voltage, type="n", xlab=xlab, ylab=ylab))
with(df,lines(date_time, Voltage, type="l"))

#set values for xlab and ylab
xlab <- ""
ylab <- "Energy sub metering"

#draw the third plot
with(df, plot(date_time, Sub_metering_1, type="n", xlab=xlab, ylab=ylab))


legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=c(1,1,1), 
       col=c("black", "red", "blue"),
       bty = "n"
      )

#add connected line segments to plot
with(df,lines(date_time, Sub_metering_1, type="l", col="black"))
with(df,lines(date_time, Sub_metering_2, type="l", col="red"))
with(df,lines(date_time, Sub_metering_3, type="l", col="blue"))

#set values for xlab and ylab
xlab <- "datetime"
ylab <- "Global_reactive_power"


#draw the fourth plot
with(df, plot(date_time, Global_reactive_power, type="n", xlab=xlab, ylab=ylab))
with(df,lines(date_time, Global_reactive_power, type="l"))


#close the png file
dev.off()






