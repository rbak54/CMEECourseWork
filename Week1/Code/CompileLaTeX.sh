#!/bin/bash
#Author: Ruth Keane ruth.keane19@imperial.ac.uk
#Script: CompileLaTex.sh
#Desc: script compiling LaTex and bibtex
#Arguments: $1-file to be compiled
#Date: Oct 2019
pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex

mv ./FirstExample.pdf ../Results/
evince ../Results/$1.pdf &

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
