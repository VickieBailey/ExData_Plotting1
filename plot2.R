## Vickie Bailey
## Exploratory Data Analysis
## Plotting Assignment 1
## Plot 2 of 4
## February 10, 2017


## Open library for required packages.
library(data.table)
library(lubridate)
library(ggplot2)

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

## Need to paste the date and time columns together in order to accurately
## obtain the POSIXlt for the time.
householdpwr$datetime <- paste(householdpwr$Date, householdpwr$Time)
householdpwr$datetime <- strptime(householdpwr$datetime, "%Y-%m-%d %H:%M:%S")

## Call the png device driver, name the file, and set the graphic size.
png("plot2.png", width = 480, height = 480)

## Prepare plots.
ggplot(data = householdpwr, aes(x = datetime, y = Global_active_power)) +
    ## Type of graph.
    geom_line() +
    ## Give y-axis label.
    ylab("Global Active Power (kilowatts)") +
    ## Create breaks for each day and tick marks as day of week.
    scale_x_datetime(date_breaks = "day", labels = date_format("%a"))+
    ## Blank background/no grid
    theme_classic() + 
    ## No x-axis title and put border around plot.
    theme(axis.title.x = element_blank(),
          panel.border = element_rect(fill = NA))

## Be sure to close device driver.
dev.off()
