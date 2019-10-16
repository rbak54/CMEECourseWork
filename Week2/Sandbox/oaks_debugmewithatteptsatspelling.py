#!/usr/bin/env python3
"""function to determine if something is an oak"""
__author__ = 'Ruth Keane(ruth.keane19@imperial.ac.uk)'
__version__ = '0.0.1'
import csv
import sys
import doctest
import re
##Desc: function to determine if something is an oak, then print oaks in a csv
##Arguments: is_an_oak has 1 argument
##Input: none (input file is obtained in script-TestOaksData.csv in Data)
##Output:csv file in Data called JustOaksData.csv
##Define function
Str1 = "Quercus"
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 
   
    >>> is_an_oak('Fagus sylvatica')
    False
   
    >>> is_an_oak('Quercus robur')
    True
   
    >>> is_an_oak('Quercusrobur')
    True
   
    >>> is_an_oak('Quercuss robur')
    True

    """

    #nam=print(name)
    
    #na=str(nam)
    #n=re.search("quercus", na)
    #if n:nam=name
     #   return True
     #if n in name.lower():
     # #else:
     #    return False
    # f=str(name)
    
    # Str2 = f
    #     #Distance = lev.distance(Str1.lower(),Str2.lower()),
    #     #Distance = lev.distance(Str1.lower(),Str2.lower()),
    # Ratio = fuzz.ratio(Str1.lower(),Str2.lower()),
    # #print(Distance)
    # #Ratio = lev.ratio(Str1.lower(),Str.higher())
    # print(Ratio)
    # #print(Str2)

    if name.lower().startswith('quercus'):
        return True
    if name.lower().startswith('qercus'):
        return True
    if name.lower().startswith('quercuss'):
        return True
    else:
        return False
    #return name.lower().startswith('quercus')
    
doctest.testmod()   
 

def main(argv): 
    """writing a csv containing oaks only--> Just Oaks data"""
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    #with open('../Data/JustOaksData.csv','w') as g:
    csvwrite = csv.writer(g)
    csvwrite.writerow(["Genus","Species"])
    for row in taxa:
    ##if the first part is not genus, then do this (if genus it will ignore that row_)
        if row[0] !=('Genus'):
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')
            if is_an_oak(row[0]) ==True:
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])     
        #return None

if __name__ == "__main__":
    """so main function is called"""
    status = main(sys.argv)
    sys.exit(status)

