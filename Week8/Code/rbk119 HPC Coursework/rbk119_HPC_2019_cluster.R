#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: rbk119_HPC_2019_cluster.R
#Desc: cluster code
#Arguments: none
#Input: none
#Output: none
#Date: Nov 2019


rm(list=ls())
graphics.off()

###go over richness , to see if my method worked
source("rbk119_HPC_2019_main.R")


#iter<-as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
iter<-300
set.seed(iter)
#if iter<25
if (iter%%4==0){
  popsize<-500
}else if (iter%%4==1){
  popsize<-1000
}else if (iter%%4==2){
  popsize<-2500
}else if (iter%%4==3){
  popsize<-5000
}

filename<-paste0("output2_",iter)
timeinhours<-0.001
#timeinhours<-11.5
timeinmins<-timeinhours*60
cluster_run(speciation_rate = personal_speciation_rate,size=popsize,wall_time=timeinmins,interval_rich = 1,interval_oct = popsize/10,burn_in_generations = 8*popsize,output_file_name = filename)
