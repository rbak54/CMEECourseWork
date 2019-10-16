#!/usr/bin/env python3 
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: lc2.py
#Desc: finding low and high rainfall months
#Arguments: none
#Input: 0
#Output: none
#Date: Oct 2019
"""finding low and high rainfall months"""
# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1)  List of months where rainfall is >100mm , and rainfall-list comprehension
rainyc= [i for i in rainfall if i[1]>100]
print(rainyc)

# (2) List of months where rainfall is <50mm-list comprehension
dryc= [i[0] for i in rainfall if i[1]<50]
print(dryc)
# (3) List of months where rainfall is >100, and rainfall- loop
rainy=[]
for i in rainfall:
    if i[1]>100:
        rainy.append(i)
print(rainy)
#list of months where rainfall <50- loop
dry=[]
for i in rainfall:
    if i[1]<50:
        dry.append(i[0])
print(dry)

