## Vickie Bailey
## Exploratory Data Analysis
## Plotting Assignment 1
## Plot 1 of 4
## February 10, 2017


## Open library for required packages.
library(data.table)

## Obtain data.
if(!file.exists("household_power_consumption.txt")){
    url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp <- tempfile()
    download.file(url, temp)
    file <- unzip(temp)
    unlink(temp)
}

## Read the data in as a data frame. Patience!
## After reviewing the UCI website, the seperator is a semicolon so be sure
## to include that in the arguments as well as the information about na's from
## the instructor.
householdpwr <- read.table(file = "household_power_consumption.txt",
                           header = TRUE, sep = ";", na.strings = "?",
                           stringsAsFactors = FALSE)

## Convert the date.
householdpwr$Date <- as.Date(householdpwr$Date, format = "%d/%m/%Y")

## Use two variables to save the two observation dates and subset for our dates. 
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
householdpwr <- householdpwr[householdpwr$Date %in% date1:date2, ]

## Convert the time characters to POSIXlt.
householdpwr$Time <- strptime(householdpwr$Time, format = "%H:%M:%S")

## Call the png device driver, name the file, and set the graphic size.
png("plot1.png", width = 480, height = 480)

## Create the histogram with appropriate arguments.
hist(householdpwr$Global_active_power, col = "red", breaks = 12,
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

## Be sure to close device driver.
dev.off()
