

#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: browse.R
#Desc: exponenial growth simulation with vector of length generations  . plots this.
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019

Exponential<- function(N0= 1, r=1, generations=10){
#exponenial growth simulation with vector of length generations  
N<-rep(NA, generations) #vector containing NA, length is generations
N[1]<-N0 #initual is N0
for (t in 2:generations){ 
  N[t]<-N[t-1]*exp(r)
  browser()
}
return(N)
}
plot(Exponential(),type="l", main="Exponential growth")
