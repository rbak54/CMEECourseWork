#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: get_TreeHeight.R
#Desc: function calculates heights of trees in a dataset. this data is exported as a csv. 
#Arguments:1
#Input: csv file containing tree distance and degrees data
#Output: file in results folder called *nameoffile*_treeheights.csv
#Date: Oct 2019

arg<-commandArgs() #can go to command line arguemtn#
file<-arg[6]
#print(file)
Trees<- read.csv(file, header= T ) #singsAsFactors = F
#empty column for height
Trees$Tree.Height.m<-NA
#calculation function
TreeHeight <-function(degrees,distance) {
  radians <- degrees * pi / 180
  height <<- distance * tan(radians)
#  print(paste("Tree height is:", height))
  return(height)
}
#calculate height in Trees
for (tree in 1:nrow(Trees)){
  degrees<-Trees[tree, "Angle.degrees"]
  distance<-Trees[tree,"Distance.m"]
  TreeHeight(degrees,distance)
  Trees$Tree.Height.m[tree]<-height
}
F<-basename(file)
F<-tools::file_path_sans_ext(F)
#utput file name as InputFileName_treeheights.csv.
#want equiv of basenae for r acting on file then
#export data
TreeFile<-paste("../Results/",F,"_treeheights.csv",sep="")
write.csv(Trees,TreeFile)
