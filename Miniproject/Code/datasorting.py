#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: datasorting.py
#Desc: initial sorting of data
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""sorting of data"""
import csv
import pandas as pd
import numpy as np
data=pd.read_csv("../Data/CRat.csv")
data= data.reindex( columns=data.columns.tolist() + ['a0','h0','a0_gen','h0_gen', 'q0_gen',"HollingI_AIC","HollingII_AIC","HollingIII_AIC","Poly2_AIC","Poly3_AIC","N","FailHolI","FailHolII","FailHolIII","FailPol2","FailPol3","aI","aII","hII","aIII","hIII","qIII",'BestAIC','BestAICHolRECAL','BestAICHol','qcil','qciu','qIIIci','best.model.type','CUTCONTEMPHOLLING','CUTCONTEMPTYPE','qcil','qciu'])
listID=np.unique(data[['ID']])

for i in listID:
    datas=data[data.ID==i]
    if len(datas)<6:
        data=data[data.ID !=i]	
data.to_csv(r'../Data/CRatsort.csv')

