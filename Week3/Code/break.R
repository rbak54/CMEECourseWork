#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: break.R
#Desc: example of a loop with break included. start with 0 and add 1 until 10(as breaks at 10)
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
i <- 0
    while(i<Inf) {
        if(i==10){
            break #breaks when i gets to 10. but otherwise woud go to inf!
        }
        else{
            cat("i equals", i, "\n")
            i <- i + 1 #INCREASE i by one each time
    }
    }
