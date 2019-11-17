#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: run_fmr_R.py
#Desc: runs fmr.R
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
"""runs fmr_R"""
subprocess.call("/usr/bin/Rscript --vanilla /Documents/CMEECourseWork/Week7/Code/fmr.R", shell=True)
process=subprocess.run("~/Documents/CMEECourseWork/Week7/Code/Rscript --vanilla ~/Documents/CMEECourseWork/Week7/Code/fmr.R", shell=False)