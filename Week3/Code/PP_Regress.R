#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: PP_Regress.R
#Desc: 
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
#graphics.off()


require(ggplot2)
MyDF<-read.csv("../Data/EcolArchives-E089-51-D1.csv")
#MyDFA<-MyDF
#logM
for (n in 1:length(MyDF$Prey.mass)) {
  if (MyDF$Prey.mass.unit[n]=="mg") {
    MyDF$Prey.mass[n]<-MyDF$Prey.mass[n]/1000
    MyDF$Prey.mass.unit[n]<-"g"
  }
}
MyDFA<-plyr::mutate(MyDF,logPredator.mass= log(Predator.mass))
MyDFA<-plyr::mutate(MyDFA,logPrey.mass= log(Prey.mass))

Predator.lifestage<-as.factor(MyDFA$Type.of.feeding.interaction)
H<-ggplot(MyDFA, aes(Prey.mass,Predator.mass, colour=Predator.lifestage))+geom_point(shape=3)
H<-H+facet_grid(Type.of.feeding.interaction ~ .)
H<-H+geom_smooth(method="lm",fullrange=TRUE) 
H<-H+scale_y_log10( breaks=c(1e-6, 1e-2, 1e+2, 1e+6))
H<-H+scale_x_log10(limits=(c(1e-10,1e+4)))
H<-H+theme_bw()+theme(plot.margin = unit(c(.5,4.5,.5,4.5),"cm"))+theme(legend.position = "bottom") + guides(colour=guide_legend(nrow=1))
H<-H+xlab("Prey Mass in grams")+ylab("Predator mass in grams")
###didnt workH<-H+labs(fill=element_text(face = "bold"))
#loop that subsets by feeding and ..., (temp subsets), then lin regression
pdf("../Results/PP_Regress.pdf", 8, 10)
print(H)
graphics.off()

##In addition, the script should calculate the regression results corresponding 
#to the lines fitted in the figure and save it to a csv delimited table called #
#(PP_Regress_Results.csv), in the Results directory. (Hint: you will have to initialize
#a new dataframe in the script to first store the calculations and then write.csv() or
#write.table() it.)
#All that you are being asked for here is results of an analysis of Linear 
#regression on subsets of the data corresponding to available Feeding Type ×
#Predator life Stage combination — not a multivariate linear model with these
#two as separate covariates!
#The regression results should include the following with appropriate headers 
#(e.g., slope, intercept, etc, in each Feeding type ×
#life stage category): regression slope, regression intercept, R2, F-statistic 
#value, and p-value of the overall regression (Hint: Review the Stats week!).

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
    if (dim(T)[1]<3) {
      Matrix[S,3]<-NA 
      Matrix[S,4]<-NA 
      Matrix[S,5]<-NA 
      Matrix[S,6]<-NA 
      Matrix[S,7]<-NA
      Matrix[S,1]<-NA
      Matrix[S,2]<-NA
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
M<-na.omit(Matrix)
write.csv(M,"../Results/PP_Regress_Results.csv")

#lim_mod <- summary(lm(logPredator.mass ~ logPrey.mass, data=MyDFA))
#
#lim_mod <- summary(lm(Predator.mass ~ Prey.mass, data=MyDFA))
#levels(MyDFA$Type.of.feeding.interaction)

#MyDF$Prey.mass.unit==mg

#R<-subset(MyDFA, MyDFA$Predator.lifestage=="postlarva/juvenile")
#R<-subset(R, R$Type.of.feeding.interaction=="piscivorous")
#R
