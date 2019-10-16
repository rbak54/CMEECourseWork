#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: sysargv.py
#Desc: counts numbers of arguments
#Arguments: any
#Input: none
#Output: none
#Date: Oct 2019
import sys
print("This is the name of the script:", sys.argv[0])
print("Number of arguments:", len(sys.argv))
print("The arguments are:",str(sys.argv))
