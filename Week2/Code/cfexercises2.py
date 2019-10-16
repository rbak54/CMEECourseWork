#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: cfexercises2.py
#Desc: practice for control flow
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
for j in range(12):
    if j % 3 ==0:
        print('hello')
#print hello for how many tmes 3 goes into 12
for j in range(15):
    if j % 5 ==3 :
        print('hello')
    elif j % 4 == 3:
        print('hello')
#print hello for how many times numbers between 1 and 15 /3 has a remainder of 3
#and how many times numbers between 1 and 15 have rem 0f 3 when divided by 4
z=0
while z !=15:
    print('hello')
    z=z+3
#print hello and add 3 if z is not 15. 
z=12
while z<100:
    if z==31:
        for k in range(7):
            print('hello')
    elif z==18:
        print('hello')
    z=z+1
#z starts at 12 , and 1 is added until it is 100 . at 31, hello is printed 7 times, at 18 it is printed once 
