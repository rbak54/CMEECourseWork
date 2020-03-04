#/bin/bash
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: run_MiniProject.sh
#Desc: runs miniproject files
#Date: Feb 2019
echo "Running datasorting.py"
python3 datasorting.py
echo "Running runif"
#Rscript modelfitting.R
echo "run analysistidied.R"
Rscript analysistidied.R
echo "Run plotting.R"
Rscript plotting.R
echo "Run texcount.sh"
bash run_texcount.sh
echo "Run CompileLaTeX.sh"
bash CompileLaTeX.sh main.tex
#remember this uses functions
