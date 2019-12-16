#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Bestanalysis.R
#Desc: analysing model results
#Arguments: none
#Input: none 
#Output: none
#Date: Dec 2019
##later maybe do this is in datamodelling tidied
require(ggplot2)
Best<-read.csv("../Results/CRatBest.csv",)
Best<-as.data.frame(Best[2:6])
colnames(Best)<-c("i","BestAIC","AIC","BestBIC","BIC")
ggplot(data=Best,aes(BestAIC))+geom_bar()
ggplot(data=Best,aes(BestBIC))+geom_bar()

#2 holling ,3 gen holling ,4 pol(polnomial degree2), 5,polc (polynomal degree3)
