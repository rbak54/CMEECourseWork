#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: PP_Lattice.R
#Desc: makes lattice graphs and finds medians and means
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
graphics.off()
library(lattice)
require(dplyr)
MyDF<- read.csv("../Data/EcolArchives-E089-51-D1.csv")
library(dplyr)
#utils::View(MyDF)
##add row for logs
DFwR<-plyr::mutate(MyDF,Ratio=Prey.mass/Predator.mass)
DFwR<-plyr::mutate(DFwR,logPredator.mass= log(Predator.mass))
DFwR<-plyr::mutate(DFwR,logPrey.mass= log(Prey.mass))
DFwR<-plyr::mutate(DFwR,logRatio= log(Ratio))
#utils::View(DFwR)
#make pdfs for pred, prey and size ratio
pdf("../Results/Pred_Lattice.pdf")
print(densityplot(~logPredator.mass| Type.of.feeding.interaction, data=DFwR))
print("Pred_Lattice.pdf in Results folder")
pdf("../Results/Prey_Lattice.pdf")
print(densityplot(~logPrey.mass| Type.of.feeding.interaction, data=DFwR))
print("Prey_Lattice.pdf in Results folder")
pdf("../Results/SizeRatio_Lattice.pdf")
print(densityplot(~logRatio| Type.of.feeding.interaction, data=DFwR))
print("SizeRatio_Lattice.pdf in Results folder")
#calculate means
meanmatrix<-matrix(NA,nrow=5,ncol=3)
M<-aggregate(DFwR$logPrey.mass,list(DFwR$Type.of.feeding.interaction),mean)
meanmatrix[,1]<-M[,2]
M<-aggregate(DFwR$logPredator.mass,list(DFwR$Type.of.feeding.interaction),mean)
meanmatrix[,2]<-M[,2]
M<-aggregate(DFwR$logRatio,list(DFwR$Type.of.feeding.interaction),mean)
meanmatrix[,3]<-M[,2]
#calculate medians
medmatrix<-matrix(NA,nrow=5,ncol=3)
E<-aggregate(DFwR$logPrey.mass,list(DFwR$Type.of.feeding.interaction),median)
medmatrix[,1]<-E[,2]
E<-aggregate(DFwR$logPredator.mass,list(DFwR$Type.of.feeding.interaction),median)
medmatrix[,2]<-E[,2]
E<-aggregate(DFwR$logRatio,list(DFwR$Type.of.feeding.interaction),median)
medmatrix[,3]<-E[,2]
#format
colnames(meanmatrix)<-c("Log.Prey.mass","Log.Predator.mass","Log.Ratio")
colnames(medmatrix)<-c("Log.Prey.mass","Log.Predator.mass","Log.Ratio")
rownames(meanmatrix)<-M[,1]
rownames(medmatrix)<-E[,1]
com<-matrix(NA, nrow=5,ncol=6)
#com<-c(meanmatrix,medmatrix)
com[,1:3]<-meanmatrix
com[,4:6]<-medmatrix
colnames(com)<-c("Mean.Log.Prey.mass","Mean.Log.Predator.mass","Mean.Log.Ratio","Median.Log.Prey.mass","Median.Log.Predator.mass","Median.Log.Ratio")
rownames(com)<-E[,1]
#wrote ito csv
write.csv(com,"../Results/PP_Results.csv")
print("PP_Results.csv in Results folder")
graphics.off()
