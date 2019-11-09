#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: divergence.R
#Desc: 
#Arguments: none
#Input: none 
#Output: none
#Date: Oct 2019

west<-read.csv("../Data/western_banded_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"), header=FALSE)
bent<-read.csv("../Data/bent-toed_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"),header=FALSE)
leap<-read.csv("../Data/leopard_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"), header=FALSE)
for (i in 1:20){
  
}
rownames(west)<-seq(1,20,1)
rownames(bent)<-seq(21,40,1)
rownames(leap)<-seq(41,60,1)
data<-rbind(west,bent,leap)




####go over
#list of variable sites same species
#pointsW<-c()
#for (i in 1:ncol(data)){
#    if(length(unique(data[1:20,i]))!=1) pointsW<-c(pointsW,i)
#  }
#pointsB<-c()
#for (i in 1:ncol(data)){
#  if(length(unique(data[21:40,i]))!=1) pointsB<-c(pointsB,i)
#}
#pointsL<-c()
#for (i in 1:ncol(data)){
#  if(length(unique(data[41:60,i]))!=1) pointsL<-c(pointsL,i)
#}
###bck to bears code
pointsW<-c()
pointsB<-c()
pointsL<-c()

for (i in 1:ncol(west)){
  if(length(unique(west[,i]))==2) pointsW<-c(pointsW,i)
}
for (i in 1:ncol(bent)){
  if(length(unique(bent[,i]))==2) pointsB<-c(pointsB,i)
}
for (i in 1:ncol(leap)){
  if(length(unique(leap[,i]))==2) pointsL<-c(pointsL,i)
}

#now want to combine these
all<-c(pointsW,pointsB,pointsL)
#now delete these variable sites for all
datasg<-data
for (site in all){
  datasg<-datasg[,-site]
}


##compare species 
pointsWB<-c()
pointsBL<-c()
pointsWL<-c()

for (i in 1:ncol(datasg)){
  # if(length(unique(datasg[c(1,21),i]))==2) pointsWB<-c(pointsWB,i)
  #if(length(unique(datasg[c(21,41),i]))==2) pointsBL<-c(pointsBL,i)
  #if(length(unique(datasg[c(1,41),i]))==2) pointsWL<-c(pointsWL,i)
  if (datasg[1,i]!=datasg[21,i]) pointsWB<-c(pointsWB,i)
  if (datasg[21,i]!=datasg[41,i]) pointsBL<-c(pointsBL,i)
  if (datasg[1,i]!=datasg[41,i]) pointsWL<-c(pointsWL,i)
}
diffWB<-length(pointsWB)
diffBL<-length(pointsBL)
diffWL<-length(pointsWL)

WB<-diffWB/i
BL<-diffBL/i
WL<-diffWL/i
###########
print(WB)
print(BL)
print(WL)



#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: divergence.R
#Desc: 
#Arguments: none
#Input: none 
#Output: none
#Date: Oct 2019

west<-read.csv("../Data/western_banded_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"), header=FALSE)
bent<-read.csv("../Data/bent-toed_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"),header=FALSE)
leap<-read.csv("../Data/leopard_gecko.csv",stringsAsFactors = FALSE, colClasses=c("character"), header=FALSE)

dataWB<-rbind(west,bent)
dataBL<-rbind(bent, leap)
dataWL<-rbind(west, leap)



#list of variable sites same species
pointsW<-c()
#for (i in 1:ncol(data)){
#   if(length(unique(data[1:20,i]))!=1) pointsW<-c(pointsW,i)
# }
pointsB<-c()
#for (i in 1:ncol(data)){
#  if(length(unique(data[21:40,i]))!=1) pointsB<-c(pointsB,i)
#}
pointsL<-c()
#for (i in 1:ncol(data)){
#  if(length(unique(data[41:60,i]))!=1) pointsL<-c(pointsL,i)
#}
###bck to bears code- seperately for each group
for (i in 1:ncol(west)){
  if(length(unique(west[,i]))!=1) pointsW<-c(pointsW,i)
}
for (i in 1:ncol(bent)){
  if(length(unique(bent[,i]))!=1) pointsB<-c(pointsB,i)
}
for (i in 1:ncol(leap)){
  if(length(unique(leap[,i]))!=1) pointsL<-c(pointsL,i)
}

#now want to combine these
#all<-c(pointsW,pointsB,pointsL)
#now delete these variable sites for all
#datasg<-data
#for (site in all){
##  datasg<-datasg[,-site]
#}


##compare species 
pointsWB<-c()
pointsBL<-c()
pointsWL<-c()
polWB<-c(pointsW,pointsB)
polBL<-c(pointsB,pointsL)
polWL<-c(pointsW,pointsL)
for (site in polWB){
  dataWB<-dataWB[,-site]
}
for (site in polBL){
  dataBL<-dataBL[,-site]
}
for (site in polWL){
  dataWL<-dataWL[,-site]
}
#for (i in 1:ncol(datasg)){
# 
#if(length(unique(datasg[c(21,41),i]))==2) pointsBL<-c(pointsBL,i)
#if(length(unique(datasg[c(1,41),i]))==2) pointsWL<-c(pointsWL,i)

#  if (datasg[1,i]!=datasg[21,i]) pointsWB<-c(pointsWB,i)
# if (datasg[21,i]!=datasg[41,i]) pointsBL<-c(pointsBL,i)
#if (datasg[1,i]!=datasg[41,i]) pointsWL<-c(pointsWL,i)#
#}
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
###########
print(WB)
print(BL)
print(WL)

e