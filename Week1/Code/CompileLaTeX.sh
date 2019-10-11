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
evince $1.pdf &
#mv ./FirstExample.pdf ../Results/FirstExample.pdf
#mv ./FirstExample.blg ../Results/FirstExample.blg
#mv ./FirstExample.bbl ../Results/FirstExample.bbl
##Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
