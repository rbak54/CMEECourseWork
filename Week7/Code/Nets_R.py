#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Nets_R.py
#Desc: converts Nets.R to a python file
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
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
#node=np.loadtxt(open("../Data/QMEE_Net_Mat_nodes.csv"),delimiter=",",skiprows=1)
tempn=[]
templ=[]
#matlinks=sc.zeros((6,7))
for row in nodes:
    tempn.append(row)
for row in links:
    templ.append(row)
# tempn=[]
#templ=sc.zeros((6,6))
#matlinks=sc.zeros((6,7))
# for row in range(6):
#     templ[row]=links[row]
## BELOW IS DRAWFW
##so first nodes from nodes(think places
# then edges from other
#network x gets coordinates from places
#p.figure()
#places=sc.array(templ[0])
place=np.array(templ[0])
places=sc.zeros(5)
for v in place:
    place[]=

#dtype which is not helping ##stuck here
pos= nx.circular_layout(places)
G=nx.Graph()
G.add_nodes_from(places)
#linkm
#H=sc.array(0)
H=[]

for r in range(6):
    for j in range(6):
        if linkm[r][j]>0:
            H.append(tuple((r,j)))
#nx.from_numpy_matrix(linkm, parallel_edges=True)
# AdjL =
# for r in range(6):
#     for j in range(6):
#         if linkm[r][j]>0:
#             np.append(H,[[r,j]])
# #sc.array(GenRdmAdjList(MaxN, C))

G.add_edges_from(H)
#NodSizs= 1000* (Sizs-min(Sizs))//(max(Sizs)-min(Sizs))
nx.draw_networkx(G, pos)
p.show()
# # AdjL
# # Sps = sc.unique(AdjL)
# SizRan = ([-10,10]) #use log10 scale- size differences usually log10
# Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)
# # p.hist(Sizs)
#.show()
# # p.hist(10**Sizs)
# # p.close('all')
# pos= nx.circular_layout(Sps)
# p.figure()
# G=nx.Graph()
# G.add_nodes_from(Sps)
# G.add_edges_from(tuple(AdjL))
# NodSizs= 1000* (Sizs-min(Sizs))//(max(Sizs)-min(Sizs))
# nx.draw_networkx(G, pos, node_size=NodSizs)
# #p.show()
# p.savefig("../Results/Network.pdf")

#need to work out templ thing , then lots more!