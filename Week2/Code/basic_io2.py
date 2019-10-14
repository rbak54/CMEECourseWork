#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: basic_io2.py
#Desc: write the numbers 1:100 in a test file in Sandbox
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
####################
#FILE OUTPUT
####################
#Save the elements of a list to a file 
list_to_save= range(100)
f=open('../Sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i)+'\n') ## add a new line at the end
f.close