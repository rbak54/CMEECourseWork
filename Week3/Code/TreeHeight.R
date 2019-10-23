#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: TreeHeight.R
#Desc: function calculates heights of trees in a dataset. this data is exported as a csv
#Arguments:none 
#Input: none
#Output: none
#Date: Oct 2019
#import data
Trees<- read.csv("../Data/trees.csv", header= T ) #singsAsFactors = F
#empty column for height
Trees$Tree.Height.m<-NA
#calculation function
TreeHeight <-function(degrees,distance) {
    radians <- degrees * pi / 180
    height <<- distance * tan(radians)
    #print(paste("Tree height is:", height))
    return(height)
}
#calculate height in Trees
for (tree in 1:nrow(Trees)){
  degrees<-Trees[tree, "Angle.degrees"]
  distance<-Trees[tree,"Distance.m"]
  TreeHeight(degrees,distance)
  Trees$Tree.Height.m[tree]<-height
}
#export data
write.csv(Trees,"../Results/TreeHts.csv")