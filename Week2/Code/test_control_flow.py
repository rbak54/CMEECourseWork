#!/usr/bin/env python3
"""Some functions exemplifying the use of control statements with doctests"""
__author__='Ruth Keane ruth.keane19@imperial.ac.uk'
__version__='0.0.1'
#Desc: contains functions exemplifying the use of control statements in python-with doctests to check if working properly
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
## imports##
## imports##
import sys #module to interface our program with the operating system
##constants##
import doctest ##to unit test

##functions##
def even_or_odd(x=0): #if not specified, x should be 0
    """Find whether a number x is even or odd.

    >>> even_or_odd(10)
    '10 is Even!'

    >>> even_or_odd(5)
    '5 is Odd!'

    whenever a float is provided, then the closest integer is used:
    >>> even_or_odd(3.2)
    '3 is Odd!'

    in case of negative numbers, the positive is taken:
    >>> even_or_odd(-2)
    '-2 is Even!'

    """
    #define function to be tested
    if x % 2 == 0: #The conditional if 
        return "%d is Even!" % x
    return "%d is Odd!" % x 


#def main(argv):
 #   print(even_or_odd(22))
    #print(even_or_odd(33))
 #    return 0
        
#if (__name__=="__main__"):
 #   """Makes sure the "main" function is called from command line"""
  #  status = main(sys.argv)
   # sys.exit(status)
doctest.testmod()