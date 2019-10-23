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

#points limited mostly to north america and europe. 
#absences likely to show lack of surverying rather than absense of the species.
#lack of data below the equator
#additionally, very small data frame

