#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: comprehensions.py
#Desc: practice for list comprehensions
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
"""practice for list comprehensions"""
#printing range(10)
x= [i for i in range(10)]
print (x)

x=[]
for i in range(10):
    x.append(i)
print(x)
###MAKE LOWER CASE
x= [i.lower() for i in ["LIST","COMPREHENSIONS","ARE","COOL"]]
print(x)

x=["LIST","COMPREHENSIONS", "ARE","COOL"]
for i in range(len(x)): #explicit loop
    x[i]=x[i].lower()
print(x)

x=["LIST ", "COMPREHENSIONS", "ARE", "COOL"]
x_new=[]
for i in x: #implicit loop 
    x_new.append(i.lower())
print(x_new)
#flatten matrix
matrix=[[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix=[]
for row in matrix: 
    for n in row:
        flattened_matrix.append(n)
print(flattened_matrix)

matrix=[[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix=[n for row in matrix for n in row]
print(flattened_matrix)
##sets
words=(["These","are", "some", "words"])
first_letters=set()
for w in words:
    first_letters.add(w[0])
print(first_letters)

words=(["These", "are", "some","word"])
first_letters={w[0] for w in words}
print(first_letters)
