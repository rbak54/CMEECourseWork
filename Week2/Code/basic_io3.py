#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: basic_io3.py
#Desc: makes a dictionary, stores this in a file using pickle and reloads it
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019

my_dictionary = { "a key":10 ,"another key":11 }

import pickle

f= open ('../Sandbox/testp.p','wb') ## note the b: accept binary files
pickle.dump(my_dictionary,f)
f.close()
##load the data again
f=open ('../Sandbox/testp.p','rb')
another_dictionary=pickle.load(f)
f.close()

print(another_dictionary)