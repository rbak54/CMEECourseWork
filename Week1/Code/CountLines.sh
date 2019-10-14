#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: CountLines
#Desc: counting lines in a file
#Input: $1-file to count lines in
#Arguments: 1
#Date: Oct 2019
if [ -e "$1" ]
then
    NumLines=`wc -l < $1`
#basename so doesn't print directory
    g=`basename $1`
    echo "The file $g has $NumLines lines"
    echo
#if no input, no error messages
else
    echo "No file inputted. Please imput file."
fi
exit
