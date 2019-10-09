#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: CountLines
#Desc: counting lines in a file
#Arguments: $1-file to count lines in
#Date: Oct 2019
NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo
exit
