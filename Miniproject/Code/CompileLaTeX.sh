#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: CompileLaTex.sh
#Desc: script compiling LaTex and bibtex
#Input: $1-file to be compiled
#Arguments: 1
#Date: Oct 2019
#change name so filename.tex works
if [ $# -eq 0 ]
then
echo "No file inputted.Please input file."
else
f=`basename $1 |cut -f 1 -d "."`
pdflatex $f
pdflatex $f
biber $f
pdflatex $f
pdflatex $f
#move pdf to results folder
mv ./$f.pdf ../Results/ ##generalise
evince ../Results/$f.pdf &

##Cleanup
rm *~
rm *.aux
rm *.xml
rm *.bcf
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.blg
rm *.pdf
fi