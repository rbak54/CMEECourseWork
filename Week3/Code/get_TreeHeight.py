#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: get_TreeHeight.py
#Desc: function calculates heights of trees in a dataset. this data is exported as a csv. 
#Arguments:1
#Input: csv file containing tree distance and degrees data
#Output: file in results folder called *nameoffile*_treeheights.csv
#Date: Oct 2019
"""Function calculates heights of trees in a dataset. this data is exported as a csv. """
#import arguments
import sys
import csv
import pandas as pd
import math
import os
if len(sys.argv)==1:
    #if no file inputted, use default
    print("No file inputted. Default: trees.csv will be used")
    Trees=pd.read_csv("../Data/trees.csv",sep=',',header=0 )
    Treesname="../Data/trees.csv"
elif len(sys.argv)==2:
    #if file inputted, use this file
    Trees=pd.read_csv(sys.argv[1],sep=',',header=0 )
    Treesname=sys.argv[1]
Trees['Tree_Height_m']="NaN"

def TreeHeight(degrees,distance):
    """calculates tree heights"""
    radians=degrees * math.pi / 180
    height=distance * math.tan(radians)
    return (height)
for tree in range(0,len(Trees)):
    #loop through all, calculating height and adding that to dataset
    degrees=Trees['Angle.degrees'][tree]
    distance=Trees['Distance.m'][tree]
    height=TreeHeight(degrees,distance)
    Trees.at[tree,'Tree_Height_m']=height
#find basename of file 
Treesname=os.path.basename(Treesname)
#remove file type info
Treesname=os.path.splitext(Treesname)[0]
#name out output file name
Treesnamefile='../Results/'+Treesname+'_treeheights.csv'
Treesnamebasename=os.path.basename(Treesnamefile)
Treesnamedir=os.path.dirname(Treesnamefile)
Trees.to_csv(Treesnamefile)
print("Tree heights calculated!")
print("Output file is",Treesnamebasename)
print("Directory of output file is",Treesnamedir)
