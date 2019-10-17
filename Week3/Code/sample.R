#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: sample.R 
#Desc: 
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019

###takes a sample size n from population and calculates mean
myexperiment <- function(popn,n){
    pop_sample <- sample(popn, n, replace=FALSE)
    return(mean(pop_sample))
}
##for 1 to num, calculate sample mean -no preallocation
loopy_sample1 <- function(popn, n, num){
    result1 <- vector() #empty vector size 1
    for(i in 1:num){
        result1 <- c(result1, myexperiment(popn, n))
    }
    return(result1)
}
##preallocation - run iterations using a for ON A VECTOR loop-preallocatin
loopy_sample2 <- function(popn, n, num){
     result2<- vector(,num) #prealocate expected size
     for (i in 1:num){
          result2[i] <- myexperiment(popn, n)
      }
     return(result2)
}
##ppreallocation- running iterations using a for loop on a LIST -preallocation
loopy_sample3<- function(popn, n, num){
    results3<-vector("list", num)
    for(i in 1:num){
            results3[[i]] <- myexperiment(popn,n)
    }
    return(results3)
}
## iterating eperienent -VECTORISATION, lapply
lapply_sample<- function(popn, n, num){
    result4<- lapply(1:num, function(i) myexperiment(popn, n))
    return(result4)
}
##iterating experiment, vectorisation, sapply
sapply_sample<- function(popn,n ,num){
    result5<- sapply(1:num, function(i) myexperiment(popn, n))
    return(result5)
}

##generate population
popn<- rnorm(1000)
hist(popn)
 n<-20  #sample size
 num<-1000 # times to rerun

print("The loopy, non-preallocation approach takes:" )
print(system.time(loopy_sample1(popn, n, num)))

print("The loopy, but with preallocation approach takes:" )
print(system.time(loopy_sample2(popn, n, num)))

print("The loopy, non-preallocation approach takes:" )
print(system.time(loopy_sample3(popn, n, num)))

print("The vectorized sapply approach takes:" )
print(system.time(sapply_sample(popn, n, num)))

print("The vectorized lapply approach takes:" )
print(system.time(lapply_sample(popn, n, num)))

