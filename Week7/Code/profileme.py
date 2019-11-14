#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: profileme.py
#Desc: profiling code
#Arguments: none
#Input: none 
#Output: none
#Date: Not 2019
"""programme for profiling code"""
def my_squares(iters):
    """find squares"""
    out=[]
    for i in range(iters):
        out.append(i**2)
    return out
def my_join(iters, string):
    """ joins iters numbers of , """
    out=''
    for i in range(iters):
        out += string.join(",")
    return out
def run_my_funcs(x,y):
    """my squares and my join"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")
