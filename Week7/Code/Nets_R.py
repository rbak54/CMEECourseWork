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
import csv
import scipy as sc
import numpy as np
import networkx as nx
import matplotlib.pyplot as p
edges= open('../Data/QMEE_Net_Mat_edges.csv','r')
links = csv.reader(edges)
node= open('../Data/QMEE_Net_Mat_nodes.csv','r')
nodes = csv.reader(node)
# temp=[]
# h=open("../Data/QMEE_Net_Mat_edges.csv","rb")
# links=csv.reader(h,delimiter=",")
# x=list(links)
linkm=np.loadtxt(open("../Data/QMEE_Net_Mat_edges.csv"),delimiter=",",skiprows=1).astype(int)
#node=np.loadtxt(open("../Data/QMEE_Net_Mat_nodes.csv"),delimiter=",",skiprows=1).astype(int)
tempn=[]
templ=[]
#matlinks=sc.zeros((6,7))
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
    #print(ee[d][0:2])
    r=tuple(sorted(ea[d][0:2]))
    num=ea[d][2]
    number=(num,)
    ea[d] = r + number
    list(set(ea))

en=ea[:]
et=ea[:] 
for d in range(len(et)):
    #print(ee[d][0:2])
    r=tuple(sorted(et[d][0:2]))
    #num=ee[d][2]
   # number=(num,)
    et[d] = r
    #r + number
    #    print(ee)
emp=sc.empty(shape=len(en))
for d in range(len(en)):
    #r=tuple(sorted(en[d][0:2]))
    #num=en[d][2]
    num=en[d][2]
    #number=(num,)
    emp[d]=num
    #en[d] = r + number
    #    print(ee)
    print(emp)

forlabs=tempn[1:]
#labels={}
#for i in range(6):
#    labels[forlabs[i][0]]=forlabs[i][1] 

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

groupsa=np.array(groups)
p.figure()
#dtype which is not helping ##stuck here
pos= nx.circular_layout(groupsa)
G=nx.Graph()
G.add_nodes_from(groupsa)
G.add_edges_from(tuple(et))
#NodSizs= 1000* (emp-min(emp))//(max(emp)-min(emp))
d=emp/100
nx.draw_networkx(G,pos)
nx.draw_networkx_edges(G, pos, width=emp/10)
#nx.draw_networkx_labels(G,pos)
p.show()
#nx.draw_networkx(G,node_color=labels['group'])

 
##done good! need to sort colours and arrows and layout next
import pandas as pd