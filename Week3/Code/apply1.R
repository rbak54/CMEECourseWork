#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: apply1.R
#Desc: 
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019

##random matrix
M <-matrix(rnorm(100),10,10)
##mean of row
RowMeans <- apply(M, 1, mean)
print(RowMeans)
##variance of rows
RowVars <- apply(M, 1, var)
print(RowVars)
##by column
ColMeans<-apply(M,2,mean)
print(ColMeans)
