#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Vectorize2.py
#Desc: stochastic ricker equation for 1000 populations
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
"""stochastic ricker equation for 1000 populations"""
import numpy as np
from timeit import default_timer as timer
from random import uniform
import math
def stochrick(p0=[uniform(0.5, 1.5) for p in range(0, 1000)],r=1.2,K=1,sigma=0.2,numyears=100):
    N=np.zeros([numyears,len(p0)])
    N[0,]=p0
    for pop in range(0,len(p0)):
        for yr in range(1,numyears):
                N[yr,pop] = N[yr-1,pop] * math.exp(r * (1 - N[yr - 1,pop] / K) + np.random.normal(0,sigma,1))        
    return(N)

def stochrickvect(p0=[uniform(0.5, 1.5) for p in range(0, 1000)],r=1.2,K=1,sigma=0.2,numyears=100):
    N=np.zeros([numyears,len(p0)])
    N[0,]=p0
    for yr in range(1,numyears):
        N[yr][:] = N[yr-1][:] * np.exp(r * (1 - N[yr - 1][:] / K) + np.random.normal(0,sigma,1))        
    return(N)

print("Stochastic Ricker takes")
start=timer()
stochrick()
end=timer()
print(end-start)
print("Vectorized Stochastic Ricker takes:")
start=timer()
stochrickvect()
end=timer()
print(end-start)