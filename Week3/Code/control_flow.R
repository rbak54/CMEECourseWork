#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: control_flow.R
#Desc: control flow tool practice
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019

##if
a <- TRUE
if (a == TRUE){
    print("a is TRUE")
} else {
    print("a is FALSE")
}

##if but single line
z <- runif(1)
if (z<= 0.5) {print ("Less than a half")}

##for loop using sequence
for (i in 1:10) {
    j <- i * i
    print(paste(i, "squared is", j))
}
##for loop vector of srings
#paste concatenates vectors by making them characters
for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')){
    print(paste('The species is',species) )      
                 }

#for loop using  a vector
v1 <- c("a","bc","def")
for (i in v1){
        print(i)
}
#while loop find squares and add 1 until 10
i<- 0
while (i<10){
    i<- i+1
    print(i^2)
}