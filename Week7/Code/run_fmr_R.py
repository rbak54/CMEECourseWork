#/usr/bin/env python3
"""running fmr.R"""
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: run_fmr_R.py
#Desc: runs fmr.R
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
import subprocess
h=subprocess.Popen("Rscript --verbose fmr.R", shell=True).wait()
if h==0:
    print("fmr.R ran successfully")
