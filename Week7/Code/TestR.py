#/usr/bin/env python3
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: TestR.py
#Desc: runs TestR.R
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""tests R.R"""
import subprocess
#run  R script and store output and success
subprocess.Popen("Rscript --verbose TestR.R > ../Results/TestR.Rout 2>../Results/TestR_errFile.Rout", shell=True).wait()
#subprocess.Popen("Rscript --verbose NonExistScript.R > ../Results/outputFile.Rout 2> ../Results/errorFile.Rout", shell=True).wait()