#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: PP_Lattice.R
#Desc: 
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019

MyDF<- read.csv("../Data/EcolArchives-E089-51-D1.csv")
library(dplyr)

MyDF %>% group_by(Type.of.feeding.interaction) %>% mean(...)

