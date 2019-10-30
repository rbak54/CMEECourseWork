#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Rodents.R
#Desc: 
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019
Rodents<-read.csv("../Data/rodents.csv")
  DS<-subset(Rodents,species=="DS")
  DSSub<-subset(DS,sex!="")
  DSSub<-subset(DSSub,yr!="NA")
  DSSub<-subset(DSSub,hfl!="NA")
MOD<-lmer(wgt~hfl*sex+(1|yr)+(1|mo), data=DSSub)
#library(ggplot2)
#ggplot(DS,aes(hfl,wgt, colour=sex))+geom_point()
#ggplot(DS,aes(hfl,wgt, colour=sex))+geom_point()
#na.omit(Rodemts))

hist(hfl, data=Ds)
##sudo apt install r-cran-lme4 in terminal