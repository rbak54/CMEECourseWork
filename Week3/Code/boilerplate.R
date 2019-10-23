#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: boilerplate.R
#Desc: boilerplate script-containing function whih finds and prints the class of the arguments
#Arguments: 2 
#Input: for MyFunction, MyFunction(Arg1,Arg)
#Output: none
#Date: Oct 2019
MyFunction <-function(Arg1, Arg2){
        print(paste("Argument", as.character(Arg1), "is a", class(Arg1)))
        print(paste("Argument", as.character(Arg2), "is a", class(Arg2)))

        return(c(Arg1, Arg2))
}
MyFunction(1,2)
MyFunction("Riki","Tiki")