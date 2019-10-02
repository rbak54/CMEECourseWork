#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: ConcatenateTwoFiles.sh
#Desc: concatenatetwo files
#Arguments: 
#Date: Oct 2019
cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3
exit