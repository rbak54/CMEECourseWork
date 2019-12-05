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

#linkm=np.loadtxt(open("../Data/QMEE_Net_Mat_edges.csv"),delimiter=",",skiprows=1).astype(int)
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
ee=[]
for i in (range(len(lin))):
    for j in (range(len(lin))):
        if int(lin[i][j])>0:
            both=(groups[i],groups[j],lin[i][j])
            ee.append(both)

ea=ee[:]
for d in range(len(ea)):
    r=tuple(ea[d][0:2])
    #r=tuple(sorted(ea[d][0:2]))
    num=ea[d][2]
    number=(num,)
    ea[d] = r + number
    #list(set(ea))

en=ea[:]
et=ea[:] 
for d in range(len(et)):
    r=tuple(et[d][0:2])
    et[d] = r
emp=sc.empty(shape=len(en))
for d in range(len(en)):
    num=en[d][2]
    emp[d]=num
    print(emp)
##BELOW IS LABELS STUFF -llav
forlabs=tempn[1:]
#lllabels={}

#for i in range(6):
 #   lllabels[forlabs[i][0]]=forlabs[i][1] 

    #labs={forlabs[i][0]:forlabs[i][1]}  
labels=pd.DataFrame({'INST':[forlabs[0][0], forlabs[1][0],forlabs[2][0],forlabs[3][0],forlabs[4][0],forlabs[5][0]], 'group':[forlabs[0][1], forlabs[1][1],forlabs[2][1],forlabs[3][1],forlabs[4][1],forlabs[5][1]]})
#carac = pd.DataFrame({ 'Inst':['A', 'B', 'C','D','E'], 'myvalue':['group1','group1','group2','group3','group3'] })
#ee[1]
# tempn=[]
#templ=sc.zeros((6,6))
#matlinks=sc.zeros((6,7))
# for row in range(6):
#     templ[row]=links[row]
## BELOW IS DRAWFW
##so first npnodes from nodes(think places
# then edges from other
#network x gets coordinates from places
#p.figure()
#places=sc.array(templ[0])
#place=np.array(templ[0])
labels['group']=pd.Categorical(labels['group'])
groupsa=np.array(groups)
p.figure()
#dtype which is not helping ##stuck here
pos= nx.spiral_layout(groupsa)
G=nx.DiGraph()
G.add_nodes_from(labels['INST']) ##this is essential for correct labelling
G.add_edges_from(tuple(et))
NodSizs= 1000* (emp-min(emp))//(max(emp)-min(emp))
d=emp/100
node_colour=labels['group'].cat.codes
nx.draw_networkx(G,pos,node_size=1500,edge_color="grey")
nx.draw_networkx_nodes(G,pos,node_color=node_colour, cmap=p.cm.brg,node_size=1500)
nx.draw_networkx_edges(G, pos, width=emp/10,edge_color="grey")
Hosting = mpatches.Patch(color='green',label="Hosting Partner")
NonHost = mpatches.Patch(color='red',label="Non-Hosting Partner")
Uni = mpatches.Patch(color='blue',label="University")
p.legend(handles=[Hosting,NonHost,Uni],loc='best')
p.show()

##not correct labelling
