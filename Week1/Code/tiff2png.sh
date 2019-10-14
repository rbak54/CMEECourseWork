#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: tiff2png.sh
#Desc: converting tiff files to png files
#Arguments: 1
#Input: none (takes any in data folder)
#Output: png file in Results
#Date: Oct 2019
for f in ../Data/*.tif;
    do
        echo "Converting $f";
        convert "$f" "$(basename "$f" .tif).png"; 
    done
mv *.png ../Results
exit
