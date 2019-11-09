#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: divergence.R
#Desc: calculate divergence between species
#Arguments: none
#Input: none 
#Output: none
#Date: Oct 2019
#load data
west<-read.csv("../Data/western_banded_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"), header=FALSE)
bent<-read.csv("../Data/bent-toed_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"),header=FALSE)
leap<-read.csv("../Data/leopard_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"), header=FALSE)
#combine datasets to compare
dataWB<-rbind(west,bent)
dataBL<-rbind(bent, leap)
dataWL<-rbind(west, leap)

#list of monomorphic sites same species
pointsW<-c()

pointsB<-c()

pointsL<-c()

for (i in 1:ncol(west)){
  if(length(unique(west[,i]))==1) pointsW<-c(pointsW,i)
}
for (i in 1:ncol(bent)){
  if(length(unique(bent[,i]))==1) pointsB<-c(pointsB,i)
}
for (i in 1:ncol(leap)){
  if(length(unique(leap[,i]))==1) pointsL<-c(pointsL,i)
}


##compare species 
pointsWB<-c()
pointsBL<-c()
pointsWL<-c()
#dselect monomorphic sites
monWB<-intersect(pointsW,pointsB)
monBL<-intersect(pointsB,pointsL)
monWL<-intersect(pointsW,pointsL)

dataWB<-dataWB[,monWB]
dataBL<-dataBL[,monBL]
dataWL<-dataWL[,monWL]

#find out differences in amino acid sequences between species
for (i in 1:ncol(dataWB)){
  if(length(unique(dataWB[,i]))!=1) pointsWB<-c(pointsWB,i)
}
for (i in 1:ncol(dataBL)){
  if(length(unique(dataBL[,i]))!=1) pointsBL<-c(pointsBL,i)
}
for (i in 1:ncol(dataWL)){
  if(length(unique(dataWL[,i]))!=1) pointsWL<-c(pointsWL,i)
}
diffWB<-length(pointsWB)
diffBL<-length(pointsBL)
diffWL<-length(pointsWL)
WB<-diffWB/ncol(dataWB)
BL<-diffBL/ncol(dataBL)
WL<-diffWL/ncol(dataWL)
mu<-WL/2*30000000
tAB<-(2*mu)/WB
#divergence time
print("Divergence time is")
print(tAB)
