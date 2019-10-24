rm(list=ls())
setwd("~/Documents/CMEECourseWork/Week4/Code")
d<-read.table("../Data/SparrowSize.txt", header=TRUE)
plot(d$Mass~d$Tarsus, ylab="Mass (g)",xlab="Tarsus (mm)", pch=19, cex=0.4)
x<-c(1:100)
b<-0.5
m<-1.5
y<-m*x+b
plot(x,y, xlim=c(0,100),ylim=c(0,100),pch=19)
d$Mass[1]
length(d$Mass)
d$Mass[1770]
plot(d$Mass~d$Tarsus, ylab="Mass (g)",xlab="Tarsus (mm)", pch=19, cex=0.4, ylim=c(-5,38), xlim=c(0,22))
