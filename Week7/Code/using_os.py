#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script:using_os.py 
#Desc: os practical
#Arguments: none
#Input: none 
#Output: none
#Date: Not 2019
"""Practical using OS"""
#load packages
import subprocess
import os
import os.path
import re
#get home directory
home = subprocess.os.path.expanduser("~")
#empty list for subdirectories and files
l=[]
#finds paths
a=subprocess.os.walk(home)
#add subdirectories and files to l
for(dir,subdir, files) in a:
    l.append(subdir)
    l.append(files)
m=str(l)
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'
FilesDirsStartingWithC=re.findall(r"'[C]{1}[\w\d\-\._]*",m)

# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'
FilesDirsStartingWithCorc=re.findall(r"'[Cc]{1}[\w\d\-\._]*",m)

# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
s=[]
a=subprocess.os.walk(home)

for(dir,subdir, files) in a:
    s.append(subdir)
t=str(s)
SubdirsstartingwithCorc=re.findall(r"'[Cc]{1}[\w\d\-\._]*",t)
