#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: csvtospace.sh
#Description: make a new file with spaces instead of commas
#Arguments: $1 -file to be converted --> text file
#Date: October 2019

new=`basename $1 | cut -f 1 -d "."` #cut with deliminator as ., 1st column
cat $1 | tr -s "," " " >> ../Results/${new}.txt  # {} to contain variable
