#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: align_seqs_better.py
#Desc: aligns sequences contained in a csv file then outputs a csv file containing the alignment and score of all of the best alignments
#Arguments: 1
#Input: csv file containing sequences
#Output: Aligns.csv
#Date: Oct 2019

# Two example sequences to match
import sys
import csv
import operator
import pickle

with open(str(sys.argv[1]),'r') as g: 
    reader=csv.reader(g, delimiter=",",quoting=csv.QUOTE_NONE)
    for row in reader:
        print(row)
    seq1=row[0]
    seq2=row[1]
    
# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignments
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
align = None
my_best_score = -1
#work out the score for each positino
for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
# if z is bigger than previous best score, dump this with pickle (Default replaces old values)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
        best=[my_best_align,my_best_score,]
        c = open('../Results/Aligns.txt','wb')
        pickle.dump(best, c)
        c.close()

    elif z == my_best_score:
      #if z= pickle load previous pickle, append to it  and dump it again
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
        best=pickle.load(open('../Results/Aligns.txt','rb'))
        best.append(my_best_align)
        best.append(my_best_score)
        best.append
        q=open('../Results/Aligns.txt','wb')
        pickle.dump(best, q)
        q.close()
#pickle-> csv file
this=pickle.load(open('../Results/Aligns.txt','rb'))
print(this)
with open('../Results/Aligns.csv','w') as a:
    csvwrite=csv.writer(a)
    csvwrite.writerow(this)
    a.close()


