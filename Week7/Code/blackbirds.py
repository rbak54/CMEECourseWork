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
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.
found=re.findall(r"(Kingdom\s[A-Z]{1}[a-z]+)[\w\s,\-\d]*(Phylum\s[A-Z]{1}[a-z]+)[\w\s,\-\d]*(Species\s[A-Z]{1}[a-z]*\s[a-z]+)[\w\s,\-\d]", text)
for item in found:
    print(item)
# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there
# are multiple ways to skin this cat! Your solution could involve multiple
# regular expression calls (easier!), or a single one (harder!)