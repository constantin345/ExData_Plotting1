


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
##create file plot2.png
png(width=480,height=480, filename="plot2.png")

#set values for xlab and ylab
xlab <- ""
ylab <- "Global Active Power (kilowatts)"


#draw a plot
with(df, plot(date_time, Global_active_power, type="n", xlab=xlab, ylab=ylab))
with(df,lines(date_time, Global_active_power, type="l"))

#close the png file
dev.off()
  






