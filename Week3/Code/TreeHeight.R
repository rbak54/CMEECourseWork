#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: TreeHeight.R
#Desc: function calculating heights of trees
#Arguments: 2
#Input: degrees-angle of elevation and distance-distrance from base of tree
#Output: height of tree with the same units as distance 
#Date: Oct 2019

TreeHeight <-function(degrees,distance) {
    radians <- degrees * pi/ 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))
    return(height)
}
TreeHeight(37,40)