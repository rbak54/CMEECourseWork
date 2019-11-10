#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: bears.R 
#Desc: variability of bears genome
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
library(matrixStats)
data<-read.csv("../Data/bears.csv", stringsAsFactors = FALSE, colClasses=c("character"))
points<-c()
####go over 
#1
for (i in 1:ncol(data)){
  if(length(unique(data[,i]))==2) points<-c(points,i)
}
#2
alleles<-c()
for (thing in points){
  alleles<-cbind(alleles,data[,thing])
}

numbers<-matrix(ncol=4, nrow=length(points))
numbers[,1]<-colCounts(alleles, value="A")
numbers[,2]<-colCounts(alleles, value="C")
numbers[,3]<-colCounts(alleles, value="T")
numbers[,4]<-colCounts(alleles, value="G")
View(numbers)

for (i in 1:nrow(numbers)){
  A<-numbers[,1]/rowSums(numbers)
  C<-numbers[,2]/rowSums(numbers)
  T<-numbers[,3]/rowSums(numbers)
  G<-numbers[,4]/rowSums(numbers)
}
  frequencies<-matrix(data=c(A,C,T,G),ncol=4, nrow=length(points))
  a<-t(frequencies)
#as.data.frame(frequencies)
rownames(a)<-c("A","C","T","G")
a[a==0]<-NA
frequencies[frequencies==0]<-NA
D=matrix(nrow=95,ncol=2)
#for (i in 1:nrow(frequencies)){
 #D[i,1]<- rowMaxs(frequencies[,i])
#}
#vector<-as.vector(frequencies)
#na.omit(vector)#for (col in 1:ncol(alleles)){
#length(vector)#colu[col]<-unique(alleles)
 # A<-count(A)
 # row
#}
#for (base in data) {
#  sequences<-length(base)- 39
   #for (point in base) 
  #as.vector(base)
#  for (each in base)  {
 #   if (base=base[0]) {
  #  print("yes")   
  #}
  #}
#}
  #for (amino in genome) {
   #   place[]
 #}
  