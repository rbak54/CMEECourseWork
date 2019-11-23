#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: blackbirds.py
#Desc: find kingdom, phylum and species from blackbirds data
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""find kingdom, phylum and species from blackbirds data"""

import re
##findall each or ...
# Read the file (using a different, more python 3 way, just for fun!)
with open('../Data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

found=re.findall(r"(Kingdom\s[A-Z]{1}[a-z]+)[\w\s,\-\d]*(Phylum\s[A-Z]{1}[a-z]+)[\w\s,\-\d]*(Species\s[A-Z]{1}[a-z]*\s[a-z]+)[\w\s,\-\d]", text)
#print out elements for each tuple in found
for item in found:
    print(item[0])
    print(item[1])
    print(item[2])
    print()
