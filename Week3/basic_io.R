#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script:basic_io.R
#Desc: 
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019
MyData <-read.csv("../Data/trees.csv", header=TRUE) ## import with headers
write.csv(MyData, "../Results/MyData.csv") #write as new file
write.table(MyData[1,], file = "../Results/MyData.csv", append=TRUE) #append to file
write.csv(MyData, "../Results/MyData.csv", row.names=TRUE)
write.table(MyData, "../Results/MyData.csv",sep=",", col.names=FALSE)
