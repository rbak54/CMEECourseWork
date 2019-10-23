#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: preallocate.R
#Desc: preallocation practice
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019 
#not preallocated
npre<-function(){
 a <- NA
 for  (i in 1:100000) {
    a<- c(a,i)
   # print(a)
    #print(object.size(a))
 }
 }
##preallocated
pre<-function(){
 a <- rep(NA,100000)
 for (i in 1:100000) {
     a[i] <- i
     #print(a)
     #print(object.size(a))
 }
}

print("Using loops, the time taken is:")
print(system.time(npre()))
print("Using preallocation, the time taken is:")
print(system.time((pre())))
