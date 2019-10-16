#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: align_seqs_fasta.py
#Desc: aligns sequences from two fasta files then produces a text file containing the best alignment and score of the best alignment
#Arguments: 2 or 0
#Input: two fasta files 
#Output: Best_Alignment_fasta.txt in Results
#Date: Oct 2019

# Two example sequences to match
import sys
import csv
a=len(sys.argv)
if a==3:
    with open(str(sys.argv[2]),'r') as h:
        seq2=h.readlines()
        seq2=seq2[1:]
        seq2=str(seq2)
        rem=",\ n'[]"
        for r in rem:
            seq2=seq2.replace(r,"")
    with open(str(sys.argv[1]),'r') as g:
        seq1=g.readlines()
        seq1=seq1[1:]
        seq1=str(seq1)
        rem=",\ n'[]"
        for r in rem:
            seq1=seq1.replace(r,"")
else:
    with open("../Data/fasta/407228326.fasta") as h:
        seq1=h.readlines()
        seq1=seq1[1:]
        seq1=str(seq1)
        rem=",\ n'[]"
        for r in rem:
            seq1=seq1.replace(r,"")
    with open("../Data/fasta/407228412.fasta") as g:
        seq2=g.readlines()
        seq2=seq2[1:]
        seq2=str(seq2)
        rem=",\ n'[]"
        for r in rem:
            seq2=seq2.replace(r,"")   
    #print(seq2)
    #s=g.read()
    #print(s)
    #ban=s.rsplit(",")
    #print(ban)
    #seq1=ban[0]
    #seq2=ban[1]
    #both work ON sEQUE
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
        ##print(i)

    # some formatted output
    ##print("." * startpoint + matched)           
    ##print("." * startpoint + s2)
    ##print(s1)
    ##print(score) 
    ##print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
        print(z)

print(my_best_align)
print(s1) ###?
print("Best score:", my_best_score)
p=open("../Results/Best_Alignment_fasta.txt","w+")
p.write("Alignment:")
p.write(my_best_align)
p.write("\n")
p.write("Best score:")
p.write(str(my_best_score))
