#/usr/bin/env python3
"""timing"""
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: timeitme.py
#Desc: using timeit module
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
####################################################################
# loops vs. list comprehensions: which is faster?
##################################################################
iters = 1000000
import timeit
#import packages to time

from profileme import my_squares as my_squares_loops
from profileme2 import my_squares as my_squares_lc

###############################################################
# loops vs. the join method for strings: which is faster?
# #############################################################

mystring = "my string"
#importing packages to time
from profileme import my_join as my_join_join
from profileme2 import my_join as my_join

#timing
#%timeit my_squares_loops(iters)
#%timeit my_squares_lc(iters)
#%timeit (my_join_join(iters, mystring))
#%timeit (my_join(iters, mystring))