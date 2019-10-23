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
e=c(levels(MyDFA$Type.of.feeding.interaction))
d=c(levels(MyDFA$Predator.lifestage))
for (n in e) {
  for (o in d){
    T<-subset(MyDFA, MyDFA$Predator.lifestage==o)
    T<-subset(MyDFA, MyDFA$Type.of.feeding.interaction==n)
    
  }
    
}
#
#lim_mod <- summary(lm(Predator.mass ~ Prey.mass, data=MyDFA))
levels(MyDFA$Type.of.feeding.interaction)

MyDF$Prey.mass.unit==mg
pdf("../Results/PP_Regress.pdf", 8, 10)
print(H)
graphics.off()


