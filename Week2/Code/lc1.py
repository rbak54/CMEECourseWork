birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
#s is list of species names
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

