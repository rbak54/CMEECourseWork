#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: graphinit.R
#Desc: making inital graphs to eyeball data
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019

require("ggplot2")

data<-read.csv("../Data/CRat.csv")

listID<-unique(data$ID)

subset<-subset(data,ID==2)
#  ggplot(data=subset,aes(x=ResDensity,N_TraitValue))+geom_point()
for (i in listID) {
    subset<-subset(data, ID==i)
    size<-nrow(subset)
    if (size > 3) {
        pdf(paste0("../Results/initgraphs/", i, ".pdf"))# Open blank pdf page using a relative path
        print(ggplot(data=subset,aes(x=ResDensity,N_TraitValue))+geom_point())
        graphics.off() 
  }
}
head(subset)
