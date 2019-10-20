#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: TreeHeight.R
#Desc: function calculates heights of trees in a dataset. this data is exported as a csv
#Arguments:none 
#Input: none
#Output: none
#Date: Oct 2019

Trees<- read.csv("../Data/trees.csv", header= T ) #singsAsFactors = F
#Trees[,"Angle"] <- as.numeric(Trees[, "Angle.degrees"])
#Trees[,"Distance"] <- as.numeric(Trees[, "Angle.degrees"])
#Trees[,"Species"] <- as.character(Trees[, "Species"])
Trees$Tree.Height.m<-NA
head(Trees)
TreeHeight <-function(degrees,distance) {
    radians <- degrees * pi / 180
    height <<- distance * tan(radians)
    #print(paste("Tree height is:", height))
    return(height)
}
for (tree in 1:nrow(Trees)){
  degrees<-Trees[tree, "Angle.degrees"]
  distance<-Trees[tree,"Distance.m"]
  TreeHeight(degrees,distance)
  Trees$Tree.Height.m[tree]<-height
}

write.csv(Trees,"../Results/TreeHts.csv")