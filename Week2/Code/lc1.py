#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: lc1.py
#Desc: file to separate latin names, common names and masses from data using both loops and comprehensions
#Arguments: none
#Date: Oct 2019
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#sc is a list of latin names
sc=[b[0] for b in birds]
#cc is a list of common names
cc=[b[1] for b in birds]
#mc i a list of masses
mc=[b[0] for b in birds]
# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
#s is list of latin names
s=[]
for b in birds:
    s.append(b[0])
print(c)
#c is list of common names
c=[]
for b in birds:
    c.append(b[1])
print(s)
#m is list of masses
m=[]
for b in birds:
    m.append(b[2])
print(m)

