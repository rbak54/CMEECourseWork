#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Vectorize1.R
#Desc: Summing the elements of a matrix using both a vectorized and non-vectorized function
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
#matrix
M <- matrix(runif(1000000),1000,1000)
#sum making a manual function
SumAllElements <- function(M) {
    Dimensions <- dim(M)
    Tot <- 0
    for (i in 1:Dimensions[1]){
        for (j in 1:Dimensions[2]){
            Tot <- Tot + M[i,j]
        }
    }
    return(Tot)
}

print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))
print("Using the in built vectorized function, the time taken is:")
print(system.time(sum(M)))