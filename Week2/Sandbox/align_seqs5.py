# Two example sequences to match
import sys
import csv
with open(str(sys.argv[1]),'r') as g: 
    ##Works sort of but 6 because brackets
    ###h = csv.reader(g,delimiter=",")
    ###fish=list(h)
    ###print(fish)
    #print(fish)
    s=g.read()
    print(s)
    ban=s.rsplit(",")
    print(ban)
    seq1=ban[0]
    seq2=ban[1]
    #seq1=str(fish[0])
    #seq1= seq1.replace("'","")
    #print(seq1)
    #seq2=str(fish[1])
    #seq2= seq2.replace("'","")
    #print(seq2)
   # seq=[]
    #for f in s:
     #   seq.append(f)
    #print(seq)
    ###seq=[]
    
    #print(fish)
    ###for f in fish:
    ###    seq.append(str(f))
    

    ###works but so clunky
   # seq=str(seq)
    #print(seq)
    
    #print(seq)
  ###  seq1=seq[0]
    #print(seq1)
    ###seq2=seq[1]
    ###rem="[]'"
    ###for r in rem:
    ###    seq1=seq1.replace(r, "")
    ###    seq2=seq2.replace(r, "")
    #seq1= seq1.replace("'","")
    #seq2= seq2.replace("'","")
    #seq1= seq1.replace("[","")
    #seq2= seq2.replace("[","")
    #seq1= seq1.replace("]","")
    #seq2= seq2.replace("]","")
    #h = csv.reader(g, delimiter=',')
    #fish=str(h)
    #print(fish)
    #seq1=fish[0]
    #seq1= seq1.replace("'","")
    print(seq1)
    #seq2=fish[1]
    #seq2= seq2.replace("'","")
    print(seq2)
    


    

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
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)
