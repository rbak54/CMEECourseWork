#/bin/bash
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: get_TreeHeight.py
#Desc: function calculates heights of trees in a dataset. this data is exported as a csv. 
#Arguments:1
#Input: csv file containing tree distance and degrees data
#Output: file in results folder called *nameoffile*_treeheights.csv
#Date: Dec 2019
echo "Running get_TreeHeight.R"
Rscript get_TreeHeight.R ../Data/trees.csv
echo "Running get_TreeHeight.py"
python3 get_TreeHeight.py ../Data/trees.csv
