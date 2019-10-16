#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: oaks.py
#Desc: explores taxa list using loops and list comprehensions
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
##Finds just the taxa that are oak
taxa=['Quercus robur',
'Fraxinus excelsior','Pinus sylvestris','Quercus cerris','Quercus petraea',
    ]

def is_an_oak(name):
    return name.lower().startswith('quercus')
##Using for loops
oaks_loops=set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

##using list comprehensions
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

##get names in UPPER CASE using for loops
oaks_loops=set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

##get names in UPPER CASE using list comprehensions
oaks_lc=set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)
