#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script:basic_io.R
#Desc: opens and inputs trees data in csv file-different ways
#Arguments: none
#Input: 0
#Output: none
#Date: Oct 2019
MyData <-read.csv("../Data/trees.csv", header=TRUE) ## import with headers
write.csv(MyData, "../Results/MyData.csv") #write as new file
#write.table(MyData[1,], file = "../Results/MyData.csv", append=TRUE) #append to file
#removed as duplicate step and causes expected error message
write.csv(MyData, "../Results/MyData.csv", row.names=TRUE)
write.table(MyData, "../Results/MyData.csv",sep=",", col.names=FALSE)
print("Trees converted")