#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Nets_R.py
#Desc: converts Nets.R to a python file
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
#load packages
"""network plot"""
import pandas as pd
import csv
import scipy as sc
import numpy as np
import networkx as nx
import matplotlib.pyplot as p
import matplotlib.patches as mpatches
edges= open('../Data/QMEE_Net_Mat_edges.csv','r')
links = csv.reader(edges)
node= open('../Data/QMEE_Net_Mat_nodes.csv','r')
nodes = csv.reader(node)
tempn=[]
templ=[]
for row in nodes:
    tempn.append(row)
for row in links:
    templ.append(row)
    f=[]
for i in range(len(tempn)):
   f.append(tempn[i][0])
groups=f[1:]
lin=templ[1:]
ea=[]
for i in (range(len(lin))):
    for j in (range(len(lin))):
        if int(lin[i][j])>0:
            both=(groups[i],groups[j],lin[i][j])
            ea.append(both)
et=ea[:] 
#for d in range(len(et)):
  #  r=tuple(sorted(ea[d][0:2])) #sorted missing here
   # et[d] = r
emp=sc.empty(shape=len(et))
for d in range(len(et)):
    num=et[d][2]
    emp[d]=num
  #  print(emp)
lllabels={}
NodSizs= 1000* (emp-min(emp))//(max(emp)-min(emp))
d=emp/100
forlabs=tempn[1:]
for i in range(6):
    lllabels[forlabs[i][0]]=forlabs[i][1] 

groupsa=np.array(groups)
p.figure()
pos= nx.kamada_kawai_layout(groupsa)
G=nx.DiGraph()
G.add_edges_from(tuple(et))
nx.draw_networkx_nodes(G,pos,node_color=node_colour)
nx.draw_networkx_edges(G, pos, width=emp/10)
p.show()
