#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: datasorting.py
#Desc: initial sorting of data
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
import csv
import pandas as pd
import numpy as np
data=pd.read_csv("../Data/CRat.csv")
#data<-read.csv("../Data/CRat.csv")
data= data.reindex( columns=data.columns.tolist() + ['a0','h0','a0_gen','h0_gen', 'q0_gen',"HollingI_AIC","HollingII_AIC","HollingIII_AIC","Poly2_AIC","Poly3_AIC","N","FailHolI","FailHolII","FailHolIII","FailPol2","FailPol3","aI","aII","hII","aIII","hIII","qIII"])
listID=np.unique(data[['ID']])
l=0
i=3
for i in listID:
    datas=data[data.ID==i]
    if len(datas)<6:
        #l=l+1
        data=data[data.ID !=i]	
data.to_csv(r'../Data/CRatsort.csv')

# if len((data[['ID']]==i)==True) <4:
    #     l=l+1
    #     #####havent tested below
    # else:
    #     uR=data['ResDensity'].unique()
    #     uN=data['N_TraitValue'].unique()
        #not working, change
        #if "nan" in uR:
           #     data = data[pd.notnull(data['ResDensity'])]
        # if "nan" in uN:
        #     data = data[pd.notnull(data['N_TraitValue'])]
        # if "NA" in uR:
        #     data = data[pd.notnull(data['ResDensity'])]
        # if "NA" in uN:
        #     data = data[pd.notnull(data['N_TraitValue'])]
#l=0 so all are at least length 4

# Holling<- function(xR,a,h){
# return((a*xR)/(1+(h*a*xR)))
# }
# #subset<-subset(data,ID==2)
# #  ggplot(data=subset,aes(x=ResDensity,N_TraitValue))+geom_point()
# #s#izes<-vector()
# for (i in listID) {
# subset<-subset(data, ID==i)
# subset<-subset[!is.na(subset$ResDensity),]  ##removing naS  
# subset<-subset[!is.na(subset$N_TraitValue),]
# size<-nrow(subset)
# if (size > 3) {
