#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Vectorize2.R
#Desc: vectorizing stochastic Ricker model
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list=ls())

stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)){#loop through the populations
    
    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr,pop] <- N[yr-1,pop] * exp(r * (1 - N[yr - 1,pop] / K) + rnorm(1,0,sigma))
    
    }
  
  }
 return(N)
}

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 
stochrickvect<-function(r=1.2,K=1,sigma=0.2,numyears=100,p0=runif(1000,.5,1.5)){
#make matrix
  N<-matrix(NA,numyears,length(p0))
#add random initial population size
  #pop<-rnorm(1000,0.5,1.5)
  N[1,]<-p0
#loop through the populations
  for (yr in 2:100){ #for each pop, loop through the years
    
    N[yr,] <- N[yr-1,] * exp(r * (1 - N[yr - 1,] / K) + rnorm(1,0,sigma))
  }
 return(N)
}

print("Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))
print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))
