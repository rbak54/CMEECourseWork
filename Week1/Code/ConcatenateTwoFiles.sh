#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: ConcatenateTwoFiles.sh
#Desc: concatenating two files
#Arguments: 3 
#Input: $1 and $2 -two files to be compiled, ($3- empty file for output)
#Output: File containing contents of $1 and $2 called Concatenated.txt in Results (unless specified as argument)
#Date: Oct 2019
# if there is a third argument, then can immediately concatenate
if [ -e "$3" ]
then
    cat $1 > $3
    cat $2 >> $3
    echo "Merged File is"
    cat $3
#if only two arguments, make a text file for new file- "Concatenated.txt in Results in directory"
else
    if [ -e "$2" ]
    then
        touch ../Results/Concatenated.txt
        FILE="../Results/Concatenated.txt"
        cat $1 > $FILE
        cat $2 >> $FILE
    echo "Merged File is"
    cat $FILE
    else
        if [ -e "$1" ]
        then
        #if one file, can't concatinate so print message
            echo "Only one file inputted."
        #if no files, can't concatinate so print message
        else 
            echo "No files inputted"
        fi
    fi
    #if [ -e "$1" ]
    #then
    #    echo "please input more arguments"
    #fi
fi
exit