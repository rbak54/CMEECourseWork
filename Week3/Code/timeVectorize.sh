#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: timeVectorize.sh
#Desc: time four Vectorize scripts
#Arguments: none
#Input: none
#Output: none
#Date: Nov 2019
#!/bin/bash 
echo "Vectorize1.py"
command time -f "real time:%e seconds" python3 Vectorize1.py |grep "real"
echo "Vectorize2.py"
command time -f "real time:%e seconds" python3 Vectorize2.py |grep "real"
echo "Vectorize1.R"
command time -f "real time:%e seconds" Rscript Vectorize1.R |grep "real"
echo "Vectorize2.R"
command time -f "real time:%e seconds" Rscript Vectorize2.R |grep "real"
