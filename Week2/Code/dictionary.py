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
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 
#dictionary={'Chiroptera','Rodentia','Afrosoricida','Carnivora'}

taxa_dic={}
for row in taxa:
    taxa_dic[row[1]]=0

for order in taxa_dic:
    yes=[]
    for row in taxa:
        if row[1] is order:
            yes.append(row[0])
    #print(yes)
    set(yes)
    taxa_dic[order]=yes
   # 
  
#TURN INTO SET
# add SET TO DICT
#deraj said to do for and do it by species or order

print(taxa_dic)

