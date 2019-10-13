# Two example sequences to match
import sys
import csv
import operator
with open(str(sys.argv[1]),'r') as g: 
    reader=csv.reader(g, delimiter=",",quoting=csv.QUOTE_NONE)
    for row in reader:
        print(row)
    seq1=row[0]
    seq2=row[1]
    #s=g.read()
    #print(s)
    #ban=s.rsplit(",")
    #print(ban)
    #seq1=ban[0]
    #seq2=ban[1]
    #both work ON sEQUENCES2
    

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
Dictionary={}
for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
 #   Q=[]
    Doc=[]
    if z >= my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
        Dictionary[my_best_align]=z
        Doc.append(z)

##### 1 doesnt work but is what I would like to do 
print(Dictionary)

print(Doc)
r=[]
list(r)
for n in Dictionary:
       if Doc[n]!= Doc[n-1]:
           r.append(Doc[n])
####2 runs but only gets one value
#Dict=max(Dictionary, key=Dictionary.get)
#print(Dict)
#Out={}
#for d in Dict:
#    Out.append(Dictionary[d])
#for d in Dictionary:
#    if d is Dict:
#        Out[d]=Dictionary[d]
#print(Out)
#only gets one!!

######quite stuck. 

t=open("../Results/Best_Alignment.txt","w+")
t.write("Alignment:")
t.write(my_best_align)
t.write("\n")
t.write("Best score:")
t.write(str(my_best_score))
