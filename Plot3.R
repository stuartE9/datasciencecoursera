# rename data file hpc.csv for convenience in finder
setwd("~/R/spec_ExploratoryGraphics")  #set working directory
pow <- read.table("hpc.csv", header=TRUE, sep=";",stringsAsFactors = FALSE)  # read data file to dataframe 'pow' and avoid pesky 'factors' problem
pow$Date <- as.Date(pow$Date, format="%d/%m/%Y") # change Date data type from 'char' to 'date'

library(dplyr)  # load dplyr for data manipulation

pow2 <- rename(pow, gap = Global_active_power, grp = Global_reactive_power, volt=Voltage, gi=Global_intensity, sm1=Sub_metering_1, sm2=Sub_metering_2, sm3=Sub_metering_3)   # create new dataframe with short column names for convenience.

pow2$gap <- as.numeric(pow2$gap)  # convert all variables to type 'numeric' except Date and Time
pow2$grp <- as.numeric(pow2$grp)
pow2$volt <- as.numeric(pow2$volt)
pow2$gi <- as.numeric(pow2$gi)
pow2$sm1 <- as.numeric(pow2$sm1)
pow2$sm2 <- as.numeric(pow2$sm2) # note sm3 was already numeric .....

powx1 <- filter(pow2, Date == "2007-02-01")  # filter 1/2/07 rows
powx2 <- filter(pow2, Date == "2007-02-02")  # filter 2/2/07 rows

powx <- rbind(powx2,powx3)  # combine both dates to give new data set for plotting

yrange <- range(c(powx$sm1,powx$sm2,powx$sm3))  # set y range for multiple plots on single frame

plot3 <- plot(powx$dtime, powx$sm1, type="l",ylim=yrange, xaxt="s",las=1,xlab=" ",ylab="Energy Submetering") # plot first
par(new=T)
plot3a <- plot(powx$dtime, powx$sm2, type="l", ylim=yrange, col="red", xaxt="s",las=1,xlab="",ylab="") # plot second
par(new=T)
plot3b <- plot(powx$dtime, powx$sm3, type="l", ylim=yrange, col="blue", xaxt="s",las=1,xlab="",ylab="") # plot third

legend("topright", c("sub_metering_1","sub_metering_2","sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue")) # add legend 

dev.copy(png, 'plot3.png') # copy graphic to png
dev.off() # create file
png("plot3.png",width=480,height=480)  # adjust image size

















