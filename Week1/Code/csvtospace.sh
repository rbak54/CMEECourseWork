#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: csvtospace.sh
#Desc: make a new file with spaces instead of commas
#Arguments: 1
#Input: $1 -file to be converted 
#Output: text file in Results
#Date: October 2019
if [ -e "$1" ]
then
    new=`basename $1 | cut -f 1 -d "."` #cut with deliminator as ., 1st column
    cat $1 | tr -s "," " " >> ../Results/${new}.txt  # {} to contain variable 
    
else
    echo "No file to convert. Please input file."
fi
exit