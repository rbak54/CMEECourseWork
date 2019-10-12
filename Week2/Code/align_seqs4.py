# Two example sequences to match
import sys
import csv
with open(str(sys.argv[1]),'r') as g: 
    h = csv.reader(g, delimiter=',')
    fish=list(h)
   # print(fish)
   # seq1=(str(fish[0]))
    #seq1= seq1.replace("'","")
   # print(seq1)
    #seq2=(str(fish[1]))
    #print(seq2)
    seq=[]
    for f in fish:
        seq.append(str(f))
    print(seq)
    str(seq)
    seq=seq.replace("'","")