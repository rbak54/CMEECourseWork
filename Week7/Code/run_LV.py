#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: run_LV.py
#Desc: runs and profiles LV1.py and LV2.py
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""runs and profiles LV1.py and LV2.py"""
import pstats
import cProfile
import LV1
import LV2

print("LV2 with arguments")
LV2.main(["LV2",1,1,1,1])
###changearg
print("LV1")
LV1.main()

#cprofiling
print("Cprofiling of LV1")
cProfile.run("LV1.main()", filename="../Results/LV1output")
f=pstats.Stats('../Results/LV1output')
#sort and shorten output
f.sort_stats('cumulative').print_stats(15)
print()
print("Cprofiling of LV2 with inputs 1,1,1,1")
##changearg
cProfile.run('LV2.main(["LV2",1,1,1,1])', filename="../Results/LV2output")
#changearg
g=pstats.Stats('../Results/LV2output')
g.sort_stats('cumulative').print_stats(15)



