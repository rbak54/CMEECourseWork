# Two example sequences to match
import sys
import csv
with open(str(sys.argv[1]),'r') as g:
    seq1=g.readlines()
    seq1=seq1[1:]
    seq1=str(seq1)
    rem=",\ n'[]"
    for r in rem:
        seq1=seq1.replace(r,"")
    print(seq1)
    print("\n")
with open(str(sys.argv[2]),'r') as h:
    seq2=h.readlines()
    seq2=seq2[1:]
    seq2=str(seq2)
    rem=",\ n'[]"
    for r in rem:
        seq2=seq2.replace(r,"")
    print(seq2)