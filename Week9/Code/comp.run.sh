#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: comp.run.sh
#Desc: compiles c files
#Arguments: none
#Input: none
#Output: none
#Date:Dec 2019

rm ./a.out
gcc -Wall $1 
./a.out