#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: rbk119_HPC_2019_challengeG.R
#Desc: challenge proforma
#Arguments: none
#Input: none
#Output: none
#Date: Nov 2019
# CMEE 2019 HPC excercises R code challenge G proforma

graphics.off()

rm(list=ls()) # nothing written elsewhere should be needed to make this work

name <- "Ruth Keane"
preferred_name <- "Ruth"
email <- "r.keane19@imperial.ac.uk"
username <- "rbk119"

# don't worry about comments for this challenge - the number of characters used will be counted starting from here

x=function(s=c(.5,0),t=pi/2,u=.1,f=1,q=s+u*c(cos(t),sin(t))){if(u==.1)frame();segments(s[1],s[2],q[1],q[2])|if(u>1e-3)x(s=q,t+f*pi/4,u*.38)|x(s=q,t,u*.87,-f)}
x()



