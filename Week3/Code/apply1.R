#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: apply1.R
#Desc: using apply to find 
#Arguments: none
#Input: none
#Output: prints RowMeans, RowVars and ColMeans
#Date: Oct 2019

##random matrix
M <-matrix(rnorm(100),10,10)
##mean of row (1 means apply across row)
RowMeans <- apply(M, 1, mean)
print(RowMeans)
##variance of rows
RowVars <- apply(M, 1, var)
print(RowVars)
##by column (2 means apply across column)
ColMeans<-apply(M,2,mean)
print(ColMeans)
