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