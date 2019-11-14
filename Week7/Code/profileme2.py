#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: profileme2.py
#Desc: profiling faster
#Arguments: none
#Input: none 
#Output: none
#Date: Not 2019
import scipy as sc
def my_squares(iters):
    """"squares list comprehension"""
    out=sc.zeros(iters)
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """ joins ',' iters times"""
    out =''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """my squares and my join"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")