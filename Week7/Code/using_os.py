#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script:using_os.py 
#Desc: os practical
#Arguments: none
#Input: none 
#Output: none
#Date: Not 2019
"""Practical using OS"""

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import os
import os.path
import re
home = subprocess.os.path.expanduser("~")
l=[]
a=subprocess.os.walk(home)
# for (dir, subdir, files) in subprocess.os.walk(home):
#    print()
b=(dir, subdir, files)
# for(dir,subdir, files) in a:
#     print(subdir)
#     print(files)
for(dir,subdir, files) in a:
    l.append(subdir)
    l.append(files)
# subprocess.os.path.join('~')
# subprocess.os.walk(top='Home')
#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")
# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
  
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'
# m=str(l)
# n=m.replace("[]","")
# re.findall(r"[\]'[Cc]{1}[\w\d-]*.[/w/d]*","\'Cab.code")
# ##weird! backslash. removes code
# re.findall(r"[Cc]{1}[\w\d-]*.[./w/d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*",'com.sun.star.comp.deployment.executable.PackageRegistryBackend')
#re.findall(r"[Cc]{1}[\w\d-]*.[./w/d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*.[\w\d]*",m)
#doesn't only get first letter c!
# #\w\d\]*.[\w\d]*&",
# Type your code here:

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
