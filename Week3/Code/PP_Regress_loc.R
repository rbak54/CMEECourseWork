#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: PP_Regress_loc.R
#Desc: calculates regressions for location
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019

MyDF<-read.csv("../Data/EcolArchives-E089-51-D1.csv")
#convert all to g for prey mass
for (n in 1:length(MyDF$Prey.mass)) {
  if (MyDF$Prey.mass.unit[n]=="mg") {
    MyDF$Prey.mass[n]<-MyDF$Prey.mass[n]/1000
    MyDF$Prey.mass.unit[n]<-"g"
  }
}
MyDFA<-plyr::mutate(MyDF,logPredator.mass= log(Predator.mass))
MyDFA<-plyr::mutate(MyDFA,logPrey.mass= log(Prey.mass))
#ggplot graph

#make linear model for each combination of interaction and lifestage
f=c(levels(MyDFA$Location))
length(f)
Matrix<-matrix(NA,nrow=25,ncol=6)
colnames(Matrix)<-c("Location", "Slope_of_regression", "Intercept_of_regression", "R-squared", "F-statistic", "p-value")
S=0
for (n in f) {
    S=S+1
    T<-subset(MyDFA, MyDFA$Location==n)
    #if too small for lm then everything is NA
    if (dim(T)[1]<3) {
      Matrix[S,3]<-NA 
      Matrix[S,4]<-NA 
      Matrix[S,5]<-NA 
      Matrix[S,6]<-NA 
      Matrix[S,1]<-NA
      Matrix[S,2]<-NA
      #otherwire run lm and replace na in matrix with needed values
      } else {
    lim_mod <- summary(lm(logPredator.mass ~ logPrey.mass, data=T))
    Matrix[S,2]<-lim_mod$coefficients[2,1]   
    Matrix[S,3]<-lim_mod$coefficients[1,1]
    Matrix[S,4]<-lim_mod$r.squared
    Matrix[S,5]<-lim_mod$fstatistic[1]
    Matrix[S,6]<-lim_mod$coefficients[2,4]
    Matrix[S,1]<-n
      }   
}
#make new matrix with only actual values
M<-na.omit(Matrix)
#make a csv of it!
write.csv(M,"../Results/PP_Regress_Results_loc.csv")

