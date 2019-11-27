rm(list=ls())
graphics.off()

source("rbk119_HPC_2019_main.R")

#iter<-as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
iter<-1
#last thing- undo above
set.seed(iter)
iter=8
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

filename<-paste0("output_",iter)
timeinhours<-60*12
cluster_run(speciation_rate = speciation_rate,size=popsize,wall_time=timeinhours,interval_rich = 1,interval_oct = popsize/10,burn_in_generations = 8*popsize,output_file_name = filename)
cluster_run()