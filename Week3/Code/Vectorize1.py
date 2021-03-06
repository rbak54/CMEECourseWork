#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Vectorize1.py
#Desc: Summing the elements of a matrix using both a vectorized and non-vectorized function
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
"""summing matrix elements two different ways and timing this"""
#import packages
from random import seed
from random import random
import numpy as np
import scipy as sc
from timeit import default_timer as timer
#initialise matrix
a=1000
mat=np.random.rand(a,a)
def SumAllElements(x):
    """sum of all elements in a matrix"""
    dim = x.shape
    Tot = 0
    for I in range(0,dim[1]):
        for J in range(0,dim[0]):    
            Tot = Tot + x[J,I]      
    return(Tot)

#time different functions
print("Using loops, the time taken is:")
start=timer()
SumAllElements(mat)
end=timer()
print(end-start)
print("using the in built vectorized function, the time taken is:")
start=timer()
np.sum(mat)
end=timer()
print(end-start)
