#!/usr/bin/env python3
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: tuple.py
#Desc: script to seperate tuples and print in sections
#Arguments: none
#Output: none
#Input: none
#Date: Oct 2019
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

for a in birds:
    print("Latin name:",a[0],)
    print("Common name:",a[1])
    print("Mass:",a[2])
    print("\n")
#for each tuple ("a"), print description then the value of that variable