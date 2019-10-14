#!/usr/bin/env python3
"""function to determine if something is an oak"""
__author__ = 'Ruth Keane()'
__version__ = '0.0.1'
import csv
import sys
import doctest
#######why am I getting fails?)
##Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 
   
    >>> is_an_oak('Fagus sylvatica')
    'False'
   
    >>> is_an_oak('Quercus robur')
    'True'
   
    >>> is_an_oak('Quercusrobur')
    'True'
   
    >>> is_an_oak('Quercuss robur')
    'True'

    """
    return name.lower().startswith('quercus')

def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
###has header is what I'm trying to do, can;t get to work!
    for row in taxa:
        if row==('Genus',' species'):
            next(taxa)
            #print(row)
            #print ("The genus is: ") 
            #print(row[0] + '\n')
            #if is_an_oak(row[0]):
             #   print('FOUND AN OAK!\n')
              #  csvwrite.writerow([row[0], row[1]])    
        else:
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])    
    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)