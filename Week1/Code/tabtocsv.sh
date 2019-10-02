#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: tabtocsv.sh
#Desc: substitutte the tabs in the files with commas
#saves the output into a .csv file
#Date:Oct 2019
echo "Creating a comma delimited verion of $1 ..."
cat $1 | tr -s "\t","," >> $1.csv
echo "Done!"
exit