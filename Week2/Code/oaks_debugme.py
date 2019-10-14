#!/usr/bin/env python3
"""function to determine if something is an oak"""
__author__ = 'Ruth Keane(ruth.keane19@imperial.ac.uk)'
__version__ = '0.0.1'
import csv
import sys
import doctest
#######why am I getting fails?)
##Define function
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
    return name.lower().startswith('quercu')

def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')

    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    csvwrite.writerow(["Genus","Species"])
    for row in taxa:
        ##if the first part is not genus, then do this (if genus it will ignore that row_)
        if row[0] !=('Genus'):
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])    

    return 0
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()