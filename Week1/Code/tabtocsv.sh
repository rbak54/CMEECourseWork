#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: tabtocsv.sh
#Desc: substitutes the tabs in the files with commas and saves the output into a .csv file
#Arguments: 1 
#Input: A tab deliminated file
#Output: A CSV file in Results
#Date:Oct 2019

if [ -e "$1" ]
then
    echo "Creating a comma delimited verion of $1 ..."
    new=`basename $1 | cut -f 1 -d "."` #cut with deliminator as ., 1st column
    cat $1 | tr -s "\t",",">> ../Results/${new}.txt  # {} to contain variable 
    echo "Done!"
else
    echo "No file to convert. Please input file."
fi
exit