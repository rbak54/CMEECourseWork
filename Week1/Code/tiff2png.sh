#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: tiff2png.sh
#Desc: converting tiff to png
#Arguments: tiff file
#Date: Oct 2019
cd ../Data
for f in *.tif;
    do
        echo "Converting $f";
        convert "$f" "$(basename "$f" .tif).png"; 
    done
cd ../Code
exit
