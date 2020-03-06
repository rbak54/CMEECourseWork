#/bin/bash
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: run_texcount.sh
#Desc: word count
#Arguments: none
#Input: none 
#Output: none
#Date: Feb 2020
texcount main.tex > ../Results/file.txt
grep "Words in text" ../Results/file.txt >../Results/Tables/wordcount.txt
echo "done"