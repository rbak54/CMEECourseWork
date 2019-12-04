#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: ho15.R
#Desc: Multiple regressions
#Arguments: none 
#Input: none
#Output: none
#Date: Oct 2019
graphics.off()
rm(list=ls())
daphnia<-read.delim("../Data/daphnia.txt")

summary(daphnia)
par(mfrow=c(1,2))
plot(Growth.rate ~ Detergent, data = daphnia)
plot(Growth.rate ~ Daphnia,data = daphnia)
require(dplyr)
daphnia %>%
  group_by(Detergent) %>%
  summarise (variance=var(Growth.rate))
daphnia %>%
  group_by(Daphnia) %>%
  summarise (variance=var(Growth.rate))
graphics.off()
hist(daphnia$Growth.rate)


seFun<- function(x) {
  sqrt(var(x)/length(x))
}
detergentMean<-with(daphnia, tapply(Growth.rate, INDEX=Detergent, FUN=mean))
detergentSEM<-with(daphnia, tapply(Growth.rate, INDEX=Detergent, FUN=seFun))
cloneMean<-with(daphnia,tapply(Growth.rate, INDEX=Daphnia, FUN=mean))
cloneSEM<-with(daphnia, tapply(Growth.rate, INDEX=Daphnia, FUN=seFun))
graphics.off()
par(mfrow=c(2,1),mar=c(4,4,1,1))
barMids<-barplot(detergentMean, xlab="Detergent type", ylab= "Population growth rate",
                 ylim=c(0,5))
#adding errors
arrows(barMids, detergentMean-detergentSEM, barMids, detergentMean + detergentSEM, code = 3, angle = 90)

barMids<-barplot(cloneMean, xlab="Daphnia clone", ylab= "Population growth rate",
                 ylim=c(0,5))
#adding errors
arrows(barMids, cloneMean- cloneSEM, barMids, cloneMean +cloneSEM, code = 3, angle = 90)

daphniaMod  <-  lm(Growth.rate  ~  Detergent  +  Daphnia,  data  =  daphnia) 	

anova(daphniaMod) 	
summary(daphniaMod)
#difference of each mean to first mean
detergentMean - detergentMean[1]

cloneMean - cloneMean[1]


daphniaANOVAMod <- aov(Growth.rate ~ Detergent + Daphnia, data= daphnia)
summary(daphniaANOVAMod)
daphniaModHSD  <-TukeyHSD(daphniaANOVAMod) 	

daphniaModHSD 	
graphics.off()
par(mfrow=c(2,1),mar=c(4,4,1,1)) 	

plot(daphniaModHSD) 	
par(mfrow=c(2,2))
plot(daphniaMod)
timber  <-  read.delim("../Data/timber.txt") 	

summary(timber) 	
##looking for outliers
graphics.off()
par(mfrow=c(2,2))
boxplot(timber$volume)
boxplot(timber$girth)
boxplot(timber$height)
#can see one outlier. seem biologically true.better to keep stuff in
##looking for homogeneity of variaces
var(timber$volume)
var(timber$girth)
var(timber$height)
#not equal really
#so standardise x for analysis?
t2<-as.data.frame(subset(timber,timber$volume!="NA"))
t2$z.girth<-scale(timber$girth)
t2$z.height<-scale(timber$height)
var(t2$z.girth)
var(t2$z.height)
plot(t2)
#are data normally distributed
graphics.off()
par(mfrow=c(2,2))
hist(t2$volume)
hist(t2$girth)
hist(t2$height)
#this is as good as it gets
#excessively many 0s?
#no
#collinearity between covariates
pairs(timber)
cor(timber)
#yeah , issue is inflates variation.
#so less likely t get signiicant result
summary(lm(girth~height, data = timber))
VIF<- 1/(1-0.27)
VIF
sqrt(VIF)
#so standard errors will be inflated by 1.17 which is ok . 
#what is acceptable varies but testing for it and keep in mind and disclose
pairs(timber)
cor(timber)
pairs(t2)
cor(t2)
#correlations are same which we want
#6. visually inspect relatinoshups
#7. consider interactinos
#model!
timberMod<-lm(volume~girth+height, data=timber)
anova(timberMod)
#both height and girth dignificant
summary(timberMod)
plot(timberMod)
#excercise 1 
#timberMod$residuals
timber$Resid<-resid(timberMod)
timber
timberless<-timber[1:30,]
timberlessMod<-lm(volume~girth+height, data=timberless)
anova(timberlessMod)
summary(timberlessMod)
plot(timberlessMod)
#results unchanged by removing outlier so would include outlier
plantGrowth  <-  read.delim("../Data/ipomopsis.txt") 	

summary(plantGrowth) 	
