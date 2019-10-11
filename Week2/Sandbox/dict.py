taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]
# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g] 'Chiroptera' : set(['Myotis lucifugus']) etc. 
#dictionary={'Chiroptera','Rodentia','Afrosoricida','Carnivora'}
#create empty dictionary
taxa_dic={}
#add every order to the dictionary by adding the second component of every row of taxa
for row in taxa:
    taxa_dic[row[1]]=0
#add every species to order by going through each order in the dictionary
for order in taxa_dic:
#create empty list
    yes=set()
#for each row in taxa, is the order is the same as the current order , if so, add the species to the dictionary
    for row in taxa:
        if row[1] is order:
            yes.add(row[0])

    #print(yes)
    #convert to set
    #still in for loop, so for each order add the set yes to the dictionary
    taxa_dic[order]=yes

print(taxa_dic)

