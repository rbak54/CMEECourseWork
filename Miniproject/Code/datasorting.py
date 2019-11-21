import csv
import pandas as pd
import numpy as np
data=pd.read_csv("../Data/CRat.csv")
#data<-read.csv("../Data/CRat.csv")
data= data.reindex( columns=data.columns.tolist() + ['a0','h0'])
listID=np.unique(data[['ID']])
l=0
i=3
for i in listID:
    datas=data[data.ID==i]
    if len(datas)<4:
        #l=l+1
        data=data[data.ID !=i]
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
data.to_csv(r'../Data/CRatsort.csv')
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
