#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: lc2.py
#Desc: finding low and high rainfall months
#Arguments: none
#Date: Oct 2019
# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1)  List of months where rainfall is >100mm-list comprehensino
rainyc= [i[0] for i in rainfall if i[1]>100]
print(rainyc)

# (2) List of months where rainfall is <50mm-list comprehensino
dryc= [i[0] for i in rainfall if i[1]<50]
print(dryc)
# (3) List of months where rainfall is >100- loop
rainy=[]
for i in rainfall:
    if i[1]>100:
        rainy.append(i[0])
print(rainy)
#list of months wehre rainfall <50- loop
dry=[]
for i in rainfall:
    if i[1]<50:
        dry.append(i[0])
print(dry)

