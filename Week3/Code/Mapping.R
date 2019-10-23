#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Mapping.R 
#Desc: Make a world map and plot species data on it 
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
require(dplyr)
load("../Data/GPDDFiltered.RData")
require("maps")
map(database="world")
lat<-gpdd$lat
long<-gpdd$long
points(long,lat,col="blue",cex=0.5)


