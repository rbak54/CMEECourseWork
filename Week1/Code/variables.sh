#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: variables.sh
#Desc: assigning variables in shell scripts
#Input: three numbers-MyVar , a , b
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
echo "you entered" $a 'and' $b ". Their sum is:"
mysum=`expr $a + $b`
echo $mysum
##trying to remove error if no input- but always shows no variabels entered
#if [ -e "$a" ]; then
#    mysum=`expr $a + $b`
#    echo $mysum
#else
#    echo "no variables were entered"
#fi
#exit
