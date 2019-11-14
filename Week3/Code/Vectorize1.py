#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Vectorize1.py
#Desc: Summing the elements of a matrix using both a vectorized and non-vectorized function
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
from random import seed
from random import random
import numpy as np
import scipy as sc
import timeit
a=5
mat=np.zeros((a,a))
for v in range(a):    
    for w in range(a):
        mat[v][w]=random()

def SumAllElements(x):
    """sum of all elements in a matrix"""
    dim = x.shape
    Tot = 0
    for I in range(0,dim[1]):
        for J in range(0,dim[0]):    
            #print(I)
            #print(J)
            #print
            Tot = Tot + x[I,J]      
            #print(Tot)
        #print(Tot)
    print(Tot)
    return(Tot)
    #print(Tot)
#SumAllElements(mat)
# def wrapper(func, *args):
#     def wrapped():
#             return func(*args)
#     return wrapped
# short_list=range(10)
# wrapped=wrapper(SumAllElements,short_list)    
#short_list=range(10)
# # wrapped=wrapper(SumAllElements,short_list)
print("Using loops, the time taken is:")
#timeit.Timer(SumAllElements(mat)
# # print("Using the in built vectorized function, the time taken is:")
# # print(system.time(sum(M)))
# for i in (1:10)):
#     print(a)

if __name__ == '__main__':
    #import timeit
    print(timeit.timeit("SumAllElements(mat)", setup="from __main__ import SumAllElements"))