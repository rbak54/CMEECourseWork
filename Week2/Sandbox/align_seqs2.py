import sys
import csv
with open(str(sys.argv[1]),'r') as g: 
    print(g.readlines()) in 
      #fieldnames=['1','2']
    #writer=csv.Dict
    #reader=csv.DictReader(g)
#for row in csv.DictReader(str(sys.argv[1]),'1 2'.split()):
 #   print(row)
    for row in csv.DictReader(g.readlines(),'1 2'.split()):
        print(row)