#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Nets_R.py
#Desc: converts Nets.R to a python file
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""network plot"""
#importing packages
import pandas as pd
import csv
import scipy as sc
import numpy as np
import networkx as nx
import matplotlib.pyplot as p
import matplotlib.patches as mpatches
#reading data
edges= open('../Data/QMEE_Net_Mat_edges.csv','r')
csvlinks = csv.reader(edges)
node= open('../Data/QMEE_Net_Mat_nodes.csv','r')
csvnodes = csv.reader(node)
#converting data from csv
listnodes=[]
listlinks=[]
for row in csvnodes:
    listnodes.append(row)
for row in csvlinks:
    listlinks.append(row)
###manipulating data for correct format
##for links
#just institution names
names=listlinks[0]
#just number of links between institutions
listlinks=listlinks[1:]
#reformatting links so two names of institutions then number of links
namesandnlinks=[]
for i in (range(len(listlinks))):
    for j in (range(len(listlinks))):
        if int(listlinks[i][j])>0:
            both=(names[i],names[j],listlinks[i][j])
            namesandnlinks.append(both)
#converting namesandnlinks into a tuple containing just the two institution names for all links
namestuple=namesandnlinks[:] 
for f in range(len(namesandnlinks)):
    r=tuple(namestuple[f][0:2])
    namestuple[f] = r
#array containing just the number of links between places
nlinksarray=sc.empty(shape=len(namesandnlinks))
for g in range(len(namesandnlinks)):
    num=namesandnlinks[g][2]
    nlinksarray[g]=num

#making data for labelling using nodes
#reformat so table of institution then group for each institution
forlabs=listnodes[1:]
labels=pd.DataFrame({'INST':[forlabs[0][0], forlabs[1][0],
    forlabs[2][0],forlabs[3][0],forlabs[4][0],forlabs[5][0]], 
    'group':[forlabs[0][1], forlabs[1][1],forlabs[2][1],forlabs[3][1],
    forlabs[4][1],forlabs[5][1]]})
#convert group to pandas categorical variable
labels['group']=pd.Categorical(labels['group'])      

###making figure
#initialise a figure
Nets=p.figure()
#initialise directed graph
G=nx.DiGraph()
#add nodes- i.e different institutions
G.add_nodes_from(labels['INST']) 
#add edges-links between institutions 
G.add_edges_from(tuple(namestuple))
#changing colour depending on type of institution (reformat so this is possible)
node_colour=labels['group'].cat.codes
#layout for graph
pos= nx.spring_layout(G)
#draw network, with grey lines and setting node size
nx.draw_networkx(G,pos,node_size=1500,edge_color="grey")
#add network nodes to graph- node colour depending on type of inst, colour map is blue red green and setting node size
nx.draw_networkx_nodes(G,pos,node_color=node_colour, cmap=p.cm.brg,node_size=1500)
#add network edges to graph- width depending on how many links an institution has , grey lines
nx.draw_networkx_edges(G, pos, width=nlinksarray/10,edge_color="grey")
#format labels and colours for figure
Hosting = mpatches.Patch(color='blue',label="Hosting Partner")
NonHost = mpatches.Patch(color='red',label="Non-Hosting Partner")
Uni = mpatches.Patch(color='lime',label="University")
#add legend to graph
p.legend(handles=[Hosting,NonHost,Uni],loc='best')
#close graph
p.close('all')
Nets.savefig("../Results/NetworkGraph.svg")
print("Graph saved as NetworkGraph.svg in Results")