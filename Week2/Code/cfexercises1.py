#!/usr/bin/env python3
"""functions demonstrating conditional expressions"""
__Author__='Ruth Keane (ruth.keane19@imperial.ac.uk)'
__version__='0.0.1'
#Desc: contains functions exemplifying the use of conditional expressions in python
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
##imports##
import sys

##functions##
#finds the square root of x
def foo_1(x):
    return x ** 0.5
#returns largest one of two valies
def foo_2(x,y):
    if x>y:
        return x
    return y 
#if not x>y>z then switches some around and returns values in the order x>y>z
def foo_3(x,y,z):
    if x>y:
        tmp=y
        y=x
        x=tmp
    if y>z:
        tmp=z
        z=y
        y=tmp
    return[x,y ,z]
#for 1 until x+1 , multiply by 1, then multiply that by 1+1 etc so the factorial
def foo_4(x):
    result = 1
    for i in range(1, x+1):
        result=result*i
    return result
#factorial (recursive) 
def foo_5(x):
    if x==1:
        return 1
    return x* foo_5(x-1)
#factorial
def foo_6(x):
    facto=1
    while x>=1: 
        facto = facto * x
        x= x-1
    return facto
#factorial again, go over

##Test arguments 
def main(argv):
    print(foo_1(16))
    print(foo_2(120,22))
    print(foo_3(27,12,98))
    print(foo_4(9))
    print(foo_5(9))
    print(foo_6(9))
    return 0 
if (__name__=="__main__"):
    """Makes sure the main function is called"""
    status =  main(sys.argv)
    sys.exit(status)