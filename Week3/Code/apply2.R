#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: apply2.R
#Desc: makes function and applies it to all rows of a matrix
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019
#multiply by 100 if sum(v) >0
SomeOperation <- function(v){
    if (sum(v)>0) {
        return(v*100)
    }
    return(v)
}
M <- matrix(rnorm(100), 10, 10)
print(apply(M, 1, SomeOperation))