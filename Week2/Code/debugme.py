#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: debugme.py
#Desc: file to debug
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
"""file to debug"""
def createabug(x):
    y=x**4
    #changed value of z so no longer an error
    z=1
    y=y/z
    return y 
createabug(25)
