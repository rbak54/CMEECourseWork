#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: csvtospace.sh
#Description: make a new file with spaces instead of commas
#Arguments: $1 -file to be converted --> csv file
#Date: October 2019
cat $1 | tr -s "," " " >> ../Results/$1.sdf
