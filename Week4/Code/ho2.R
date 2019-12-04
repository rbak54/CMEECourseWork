
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: ho2.R
#Desc: distributions
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
#install.packages("lme4") 	
#library(lme4) 	
#require(lme4) 	
rm(list=ls())
graphics.off()

d<-read.table("../Data/SparrowSize.txt", header=TRUE)
str(d)
### lundi dataset. very isolated popuation. can record fitness which is rare.
#statistics - sample some to infer things about population. measure of uncertainty- how sure are we!
#complete population -- not possible. 
#variance is important- min/max or spread necessary
#cohort. when new. 
#sex-both integer or word
#year of cohort- year 2001-info about age but only relative to capture year
  #so may need treating as fators
#sex - treating as factors useful 
names(d)

head(d)
length(d$Tarsus)
hist(d$Tarsus)
#measures on centrality
mean(d$Tarsus,na.rm=TRUE)
median(d$Tarsus,na.rm=TRUE)
mode(d$Tarsus)

##mode difficult to clculate in continous dataset- as repeated unlikely
#measures of variation
#IQR, the value to which a given percent of data are <=  
#range
#variance-for all values, calc difference from mean (squared), / n+1
par(mfrow=c(2,2))
hist(d$Tarsus, breaks=3, col="grey")
hist(d$Tarsus, breaks=10, col="grey")
hist(d$Tarsus, breaks=30, col="grey")
hist(d$Tarsus, breaks=100, col="grey")

#source("http://bioconductor.org/biocLite.R")
#biocLite("genefilter")
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#summary stats at start of results section needed- central and measurement
#bil, mass, wilng length= mean var and sd. plot all 4 in a multi planel figure
mean(d$Bill,na.rm=TRUE)
mean(d$Mass,na.rm=TRUE)
mean(d$Wing,na.rm=TRUE)
var(d$Bill,na.rm=TRUE)
var(d$Mass,na.rm=TRUE)
var(d$Wing,na.rm=TRUE)
sd(d$Bill,na.rm=TRUE)
sd(d$Mass,na.rm=TRUE)
sd(d$Wing,na.rm=TRUE)
graphics.off()
par(mfrow=c(2,2))
hist(d$Tarsus)
hist(d$Bill)
hist(d$Wing)
hist(d$Mass)
#sum of squares
d2<-subset(d, d$Tarsus!="NA")
#na.rm is another way 
zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)
zTarsus
var(zTarsus)
sd(zTarsus)
hist(zTarsus)
set.seed(123)
dev.off()
znormal<-rnorm(1e+06)
hist(znormal,breaks=100)
q<-qnorm(c(0.025,0.975))
#
pnorm(q)
#gets probability of getting above 
graphics.off()
par(mfrow=c(1,2))
hist(znormal, breaks=100)
abline(v=qnorm(c(0.25,0.5,0.75)),lwd=2)
abline(v=qnorm(c(0.025,0.975)),lwd=2,lty="dashed")


plot(density(znormal))
abline(v=qnorm(c(0.25,0.5,0.75)),lwd=2,col="gray")
abline(v=qnorm(c(0.025,0.975)),lty="dotted",col="black")
abline(h=0, lwd=3, col="blue")
text(2, 0.3, "1.96", col="red", adj=0)
text(-2,0.3,"-1.96", col="red", adj=1)
graphics.off()
boxplot(d$Tarsus~d$Sex.1, col = c("red", "blue"), ylab="Tarsus length (mm)")
###standardising vectors???? missed this bit 

##types of data- continuges vs discrete. continous can do better statistics. 
##z distribtution subset (of normAL???) where mean is 0, sd -=1
##0s can mean different things! not seen or actually not there
#dusrete or numerical - can be binomial. working out how to measure numerically is important. eg sex= 0 /1 absent or present

##giving things numbers doesn#y work if there are more than 2 - eg green blue red. if 1,2,3 then saying that red more different to geen than blue
##categoical can be ranked or norminal (but don't use as response varibale in project!)
#year
#non-parametric tests exist but really difficult!!!