#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: ho10.R
#Desc: linear models
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019rm(list=ls())
#setwd("~/Documents/CMEECourseWork/Week4/Code")
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
plot(d$Mass~d$Tarsus, ylab="Mass (g)"
     ,xlab="Tarsus (mm)", pch=19, cex=0.4,
     ylim=c(-5,38), xlim=c(0,22))
plot(d$Mass~d$Tarsus, ylab="Mass (g)"
     ,xlab="Tarsus (mm)", pch=19, cex=0.4)

d1<-subset(d,  d$Mass!="NA") 	
d2<-subset(d1,  d1$Tarsus!="NA") 	
length(d2$Tarsus) 	
model1<-lm(Mass~Tarsus, data=d2)
#dfs- number of observations -3 estimated parameters
#r^2 23% of variance in mass exaplined by variation in tarsus
summary(model1)
hist(model1$residuals)

model2<-lm(y~x)
summary(model2)

#run model with z scores instead of tarsus
d2$z.Tarsus<-scale(d2$Tarsus)
model3<-lm(Mass~z.Tarsus,data=d2)
summary(model3)
plot(d2$Mass~d2$z.Tarsus, pch=19, cex=0.4)
abline(v=0, lty="dotted")
head(d)
str(d)
graphics.off()
d$Sex<-as.numeric(d$Sex)
par(mfrow=c(1,2))
plot(d$Wing~d$Sex.1, ylab="Wing(mm)")
plot(d$Wing~d$Sex, xlab="Sex",xlim=c(-0.1,1.1),ylab="")
abline(lm(d$Wing~d$Sex), lwd=2)
text(0.15,76,"intercept")
text(0.9,77.5,"slope", col="red")

d4<-subset(d,d$Wing!="NA")
m4<-lm(Wing~Sex, data=d4)
t4<-t.test(d4$Wing~d4$Sex, var.equal=TRUE)       
summary(m4)
t4
par(mfrow=c(2,2))
plot(model3)

par(mfrow=c(2,2))
plot(m4)
##top left  -residuals-- random distribution is what we want
#qq plot should be straight line
d5<-subset(d1,d1$Bill!="NA")
model5<-lm(Mass~Bill, data=d5)
summary(model5)
plot(d5$Mass,d5$Bill)
