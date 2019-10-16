#######################
# FILE INPUT
#######################
#Open a file for reading
f = open ('../Sandbox/test.txt','r')
#use "implicit for loop"
#if th object is a file, python will cycle over 
for line in f:
    print (line)
#close the file
f.close()
#Same example, skip blank lines
f=open('../Sandbox/test.txt','r')
for line in f:
    if len(line.strip())>0:
        print(line)
f.close()
####################
#FILE OUTPUT
####################
#Save the elements of a list to a file 
list_to_save= range(100)
f=open('../Sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i)+'\n') ## add a new line at the end
f.close
######################
#Storing opjects
#####################
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