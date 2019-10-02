#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: variables.sh
#Desc: assigning variables in shell scripts
#Arguments: none
#Date: Oct 2019
#use of variables
MyVar='some string'
echo 'the current value of the variable is' $MyVar
echo 'please enter a new string'
read MyVar
echo 'the current value of the variable is' $MyVar
##using multiple variables
echo 'Enter two numbers separated by space(s)'
read a b 
echo "you entered $a and $b. Their sum is:"
mysum=`expr $a + $b`
echo $mysum

exit