#!/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: basic_csv.py
#Desc: opens a csv data file and prints the species from it. Then writes a new csv file containing the species and the body mass.
#Arguments: none
#Input: none
#Output: bodymass.csv in Data
#Date: Oct 2019
import csv
#read a file containing :
#'Species', 'Infraorder','Family','Distribution','
f = open('../Data/testcsv.csv','r')
csvread = csv.reader(f)
temp = []
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print("This species is", row[0])
f.close()

#write a file containing only species name and Body Mass
f=open('../Data/testcsv.csv','r')
g=open('../Data/bodymass.csv','w')

csvread = csv.reader(f)
csvwrite=csv.writer(g)
for row in csvread:
        print(row)
        csvwrite.writerow([row[0],row[4]])
f.close()
g.close()
