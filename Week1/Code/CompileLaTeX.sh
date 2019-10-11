#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: CompileLaTex.sh
#Desc: script compiling LaTex and bibtex
#Arguments: $1-file to be compiled
#Date: Oct 2019
f=`basename $1 |cut -f 1 -d "."`
pdflatex $f
pdflatex $f
bibtex $f
pdflatex $f
pdflatex $f

mv ./FirstExample.pdf ../Results/
evince ../Results/$f.pdf &

##Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.blg
