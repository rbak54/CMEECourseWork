#/usr/bin/env python3

#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: DrawFW.py
#Desc: plotting a food network
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""food network plotting"""
#import packages
import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

def GenRdmAdjList(N = 2, C = 0.5):
    """generates synthetic food web"""
    #n-numbers of species, c-probability of observing connection
    Ids= range(N)  
    ALst= []
    for i in Ids:
        #implicit loop
        if sc.random.uniform(0,1,1) < C:
            #1 sample from random uniform distribution (0-1).<0.5?
            Lnk = sc.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]:
            #avoiding cannibalistic links for now
                ALst.append(Lnk)
    return ALst

#set parameters for random GenRdmAdjList. then use GenRdmAdjList to create nodes
MaxN = 30
C = 0.75
AdjL = sc.array(GenRdmAdjList(MaxN, C))
Sps = sc.unique(AdjL)

#generate body sizes
SizRan = ([-10,10]) #use log10 scale- size differences usually log10
Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)
pos= nx.circular_layout(Sps)

#plot
p.figure()
G=nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL))
NodSizs= 1000* (Sizs-min(Sizs))//(max(Sizs)-min(Sizs))
nx.draw_networkx(G, pos, node_size=NodSizs,node_color="r")
p.savefig("../Results/Network.pdf")
print("Network.pdf in Results")
