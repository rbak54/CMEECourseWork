#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: PP_Regress.R
#Desc: makes a ggplot graph and does linear regressions for type of feeding interaction and lifestage
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019

require(ggplot2)
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
Predator.lifestage<-as.factor(MyDFA$Type.of.feeding.interaction)
H<-ggplot(MyDFA, aes(Prey.mass,Predator.mass, colour=Predator.lifestage))+geom_point(shape=3)
H<-H+facet_grid(Type.of.feeding.interaction ~ .)
H<-H+geom_smooth(method="lm",fullrange=TRUE) 
H<-H+scale_y_log10( breaks=c(1e-6, 1e-2, 1e+2, 1e+6))
H<-H+scale_x_log10(limits=(c(1e-10,1e+4)))
H<-H+theme_bw()+theme(plot.margin = unit(c(.5,4.5,.5,4.5),"cm"))+theme(legend.position = "bottom") + guides(colour=guide_legend(nrow=1))
H<-H+xlab("Prey Mass in grams")+ylab("Predator mass in grams")
pdf("../Results/PP_Regress.pdf", 8, 10)
print(H)
graphics.off()

#make linear model for each combination of interaction and lifestage
e=c(levels(MyDFA$Type.of.feeding.interaction))
d=c(levels(MyDFA$Predator.lifestage))
Matrix<-matrix(NA,nrow=30,ncol=7)
colnames(Matrix)<-c("Predator_lifestage", "Type_of_feeding_interaction", "Slope_of_regression", "Intercept_of_regression", "R-squared", "F-statistic", "p-value")
S=0
for (n in e) {
  for (o in d){
    S=S+1
    T<-subset(MyDFA, MyDFA$Predator.lifestage==o)
    T<-subset(T, T$Type.of.feeding.interaction==n)
    #if too small for lm then everything is NA
    if (dim(T)[1]<3) {
      Matrix[S,3]<-NA 
      Matrix[S,4]<-NA 
      Matrix[S,5]<-NA 
      Matrix[S,6]<-NA 
      Matrix[S,7]<-NA
      Matrix[S,1]<-NA
      Matrix[S,2]<-NA
      #otherwire run lm and replace na in matrix with needed values
      } else {
    lim_mod <- summary(lm(logPredator.mass ~ logPrey.mass, data=T))
    Matrix[S,3]<-lim_mod$coefficients[2,1]   
    Matrix[S,4]<-lim_mod$coefficients[1,1]
    Matrix[S,5]<-lim_mod$r.squared
    Matrix[S,6]<-lim_mod$fstatistic[1]
    Matrix[S,7]<-lim_mod$coefficients[2,4]
    Matrix[S,1]<-o
    Matrix[S,2]<-n
      }   
     }
}
#make new matrix with only actual values
M<-na.omit(Matrix)
#make a csv of it!
write.csv(M,"../Results/PP_Regress_Results.csv")
print("PP_Regress_Results.csv in Results")
