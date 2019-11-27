#/usr/bin/env python3
"""regex practice"""
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: regex.py
#Desc: regex practice
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
#import packages
import re
my_string = "a given string"
match= re.search(r'\s', my_string)
print(match)
match.group()
match=re.search(r'\d', my_string)
print(match)
MyStr = 'an example'
match=re.search(r'\w*\s', MyStr)
if match:
    print('found a match:', match.group())
else:
    print('did not find a match')

match=re.search(r'2', " it takes 2 to tango")
match.group()
match=re.search(r'\d', "it takes 2 to tango")
match.group()
match=re.search(r'\d.*', "it takes 2 to tango")
match.group()
match=re.search(r'\s\w{1,3}\s', "once upon a time")
match.group()
match=re.search(r'\s\w*$','once upon a time')
match.group()
re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()
re.search(r'^\w*.*\s', 'once upon a time').group()
re.search(r'<.+>', 'This is a <EM>first</EM> test').group()
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()
re.search(r'\d*\.?\d*','1432.75+60.22i').group()
re.search(r'[AGTC]+','the sequence ATTCGT').group()
re.search(r'\s+[A-Z]\w+\s*\w+',"The bird-shit frog's name is Theloderma asper.").group()
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match=re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group()
MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match=re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match=re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
#first part of 0
match.group(0)
###PRACTICALS
##creating groups
match= re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)",MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr)
for email in emails:
    print(email)
f=open('../Data/TestOaksData.csv','r')
found_oaks=re.findall(r"Q[\w\s].*\s", f.read())
found_oaks
found_matches= re.findall(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+)", MyStr)
found_matches
for item in found_matches:
    print(item)
import urllib3
conn=urllib3.PoolManager()
r=conn.request('GET','https://www.imperial.ac.uk/silwood-park/academic-staff/')
webpage_html=r.data
type(webpage_html)
My_Data= webpage_html.decode()
#print(My_Data)
pattern= r"((Dr*)|(Prof\w*))\s+\w+\s+\w+"
#not quite
regex=re.compile(pattern)
for match in regex.finditer(My_Data):
    print(match.group())
New_Data=re.sub(r'\t'," ", My_Data)
print(New_Data)


re.search(r'(([1][9])|([2][0]))[0-9]{2}[0-1][0-9][0-3][1-9]',"19001212").group()