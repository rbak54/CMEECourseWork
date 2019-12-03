#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: run_LV.py
#Desc: runs and profiles LV1.py and LV2.py
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""runs and profiles LV1.py and LV2.py"""
#import packages
import pstats
import cProfile
import LV1
import LV2
import LV3
import LV4
import LV5
#run each of LVs
print("LV1")
LV1.main()
print("LV2 with arguments")
LV2.main(["LV2",1,0.2,1.3,0.7])
print("LV3")
LV3.main()
print("LV4")
LV4.main()
print("LV5")
LV5.main()
#cprofiling
print("Cprofiling of LV1")
cProfile.run("LV1.main()", filename="../Results/LV1output")
f=pstats.Stats('../Results/LV1output')
#sort and shorten output
f.sort_stats('cumulative').print_stats(15)
print()
print("Cprofiling of LV2 with inputs 1,0.2,1.3,0.7")
##changearg
cProfile.run('LV2.main(["LV2",1,0.2,1.3,0.7])', filename="../Results/LV2output")
#changearg
g=pstats.Stats('../Results/LV2output')
g.sort_stats('cumulative').print_stats(15)
print()
print("Cprofiling of LV3")
cProfile.run("LV3.main()", filename="../Results/LV3output")
h=pstats.Stats('../Results/LV3output')
#sort and shorten output
h.sort_stats('cumulative').print_stats(15)
print()
print("Cprofiling of LV4")
cProfile.run("LV4.main()", filename="../Results/LV4output")
m=pstats.Stats('../Results/LV4output')
#sort and shorten output
m.sort_stats('cumulative').print_stats(15)
print()
print("Cprofiling of LV5")
cProfile.run("LV5.main()", filename="../Results/LV5output")
n=pstats.Stats('../Results/LV5output')
#sort and shorten output
n.sort_stats('cumulative').print_stats(15)


