#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: PP_Lattice.R
#Desc: 
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019
graphics.off()
library(lattice)
require(dplyr)
MyDF<- read.csv("../Data/EcolArchives-E089-51-D1.csv")
library(dplyr)
#utils::View(MyDF)
DFwR<-plyr::mutate(MyDF,Ratio=Prey.mass/Predator.mass)
DFwR<-plyr::mutate(DFwR,logPredator.mass= log(Predator.mass))
DFwR<-plyr::mutate(DFwR,logPrey.mass= log(Prey.mass))
DFwR<-plyr::mutate(DFwR,logRatio= log(Ratio))
#utils::View(DFwR)
pdf("../Results/Pred_Lattice.pdf")
print(densityplot(~logPredator.mass| Type.of.feeding.interaction, data=DFwR))
pdf("../Results/Prey_Lattice.pdf")
print(densityplot(~logPrey.mass| Type.of.feeding.interaction, data=DFwR))
pdf("../Results/SizeRatio_Lattice.pdf")
print(densityplot(~logRatio| Type.of.feeding.interaction, data=DFwR))

meanmatrix<-matrix(NA,nrow=5,ncol=3)
M<-aggregate(DFwR$logPrey.mass,list(DFwR$Type.of.feeding.interaction),mean)
meanmatrix[,1]<-M[,2]
M<-aggregate(DFwR$logPredator.mass,list(DFwR$Type.of.feeding.interaction),mean)
meanmatrix[,2]<-M[,2]
M<-aggregate(DFwR$logRatio,list(DFwR$Type.of.feeding.interaction),mean)
meanmatrix[,3]<-M[,2]
#meanmatrix
medmatrix<-matrix(NA,nrow=5,ncol=3)
E<-aggregate(DFwR$logPrey.mass,list(DFwR$Type.of.feeding.interaction),median)
medmatrix[,1]<-E[,2]
E<-aggregate(DFwR$logPredator.mass,list(DFwR$Type.of.feeding.interaction),median)
medmatrix[,2]<-E[,2]
E<-aggregate(DFwR$logRatio,list(DFwR$Type.of.feeding.interaction),median)
medmatrix[,3]<-E[,2]
medmatrix
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
write.csv(com,"../Results/PP_Results.csv")
graphics.off()
#men<-tapply(DFwR$logPrey.mass,DFwR$Type.of.feeding.interaction,mean,simplify = FALSE)
#med<-tapply(DFwR$logPrey.mass,DFwR$Type.of.feeding.interaction,median)
#both<-c(men,med)
#MEN<-as.matrix(men)
#as.data.frame(men)
#as.data.frame(med)
##both
#class(men)
#men
#running this script should result in three files called Pred_Lattice.pdf, Prey_Lattice.pdf, 
#and SizeRatio_Lattice.pdf being saved in the Results directory (the names should be self-explanatory).

#In addition, the script should calculate the mean and median log predator mass, prey mass, and#
#predator-prey size ratio, by feeding type, and save it as a single csv output table called PP_Results.csv 
#to the Results directory. The table should have appropriate headers (e.g., Feeding type, Mean, Median). 
#(Hint: you will have to initialize a new dataframe or matrix in the script to first store the calculations)

#The script should be self-sufficient and not need any external inputs — it should import the above 
#predator-prey dataset from the appropriate directory, and save the graphic plots to the appropriate directory 
##(Hint: use relative paths!).

#There are multiple ways to do this practical. The plotting and saving component is simple enough. For calculating 
#the statistics by feeding type, you can either use the "loopy" way — first obtaining a list of feeding types (look
#up the unique or levels functions) and then loop over them, using subset to extract the dataset by feeding type at 
#each iteration, or the R-savvy way, by using tapply or ddply and avoiding looping altogether.


#his practical, you will write script that draws and saves three lattice graphs
#by feeding interaction type: one of predator mass, one of prey mass and one of 
#t#he size ratio of prey mass over predator mass. Note that you would want to use 
#logarithms of masses (or mass-ratios)for all three plots. 
#In addition, the script #will calculate the mean and median
#predator mass, prey mass and predator-prey size-
  #ratios to a csv file. So:
#mean(DFwR$lgPrey.mass[type.of.feeding.interaction==predacious])
#c=c("logPrey.mass","logPredator.mass","logRatio")
#bothmatrix<-matrix(NA,nrow=5,ncol=3)
#colnames(bothmatrix)=c
#bothmatrix
#for (i in bothmatrix){
#  M<-aggregate(DFwR$i,list(DFwR$Type.of.feeding.interaction),mean)
#  bothmatrix[,i]<-M[,2]
#}