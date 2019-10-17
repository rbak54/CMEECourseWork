##simulation involving sampling from a popn

doit<-function(x){
    temp_x<- sample(x, replace = TRUE)
    if(length(unique(temp_x))>30){
        print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        }
    else {
        stop("Couldn't calculate mean:too few unique points!")
    }
}

#popn<-rnorm(50) #gen popn
#lapply(1:15,function(i) doit(popn))
##try using "try" with vectorisation:
result<- lapply(1:15, function(i) try(doit(popn),FALSE))
class(result)
###using for loop 
#result<- vector("list",100) #reallocate/initialse
#for (i in 1:100) {
#    result[[i]] <- try(doit(popn), FALSE)

}

# 