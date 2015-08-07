

library(dplyr)

#read the file
#using filter function from dplyr
#keep only the rows that have date "1/2/2007" or "2/2/2007"
df <- read.table(file="household_power_consumption.txt", 
                 sep=";", header=TRUE, 
                 stringsAsFactors=FALSE,
                 na.strings="?",
                 colClasses=c("character", "character", "numeric",
                              "numeric", "numeric", "numeric", 
                              "numeric", "numeric", "numeric")
                 ) %>% 
                  filter(Date =="1/2/2007" | Date =="2/2/2007") 

##open png device
##create file plot1.png
png(width=480, height=480, filename="plot1.png")

#draw a histogram
with(df,
     hist(Global_active_power, col="red", main="Global Active Power",
     freq=TRUE, xlab="Global Active Power (kilowatts)"))

#close the png file
dev.off()
