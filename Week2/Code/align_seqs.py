#!/usr/bin/env python3 
"""Takes DNA sequences from an external file, finds their best alignment and saves it in a text file """
__appname__='[align sequences]'
__author__='Ruth Keane (ruth.keane19@imperial.ac.uk)'
__version__='0.0.1'
__license__='Public domain'
#Desc: aligns sequences from two fasta files then produces a text file containing the best alignment and score of the best alignment
#Arguments: 1
#Input: csv file containing sequences
#Output: Best_Alignment.txt in Results
#Date: Oct 2019
###imports###
import sys
import csv
###inputs###
#if no input, both sequence 1 and 2 just contain original sequences as defaults
if len(sys.argv) ==2: 
    with open(str(sys.argv[1]),'r') as g: 
        reader=csv.reader(g, delimiter=",",quoting=csv.QUOTE_NONE)
        for row in reader:
            print(row)
        seq1=row[0]
        seq2=row[1]  
else:
    seq1="ATCGCCGGATTACGGG"
    seq2 = "CAATTCGGAT"

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
##functions##
def calculate_score(s1, s2, l1, l2, startpoint):
    """calculating score"""
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
    #print("." * startpoint + matched)           
    #print("." * startpoint + s2)
    #print(s1)
    #print(score) 
    #print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
def main(argv):
 """"part of programme where score is calculated"""
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        print(z)
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
#my_best_align
#my_best_score
#with open('../Results/Best_Alignment.csv','w') as t:
t=open("../Results/Best_Alignment.txt","w+")
t.write("Alignment:")
t.write(my_best_align)
t.write("\n")
t.write("Best score:")
t.write(str(my_best_score))
t.close()

if __name__=="___main___":
    """Ensures that the main function is called"""
    status = main(sys.argv)
    sys.exit(status)