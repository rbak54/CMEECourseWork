require("minpack.lm")
require("ggplot2")
data<-read.csv("../Data/CRatsort.csv")


Start<- function(subset){
  h0=max(subset$N_TraitValue)
  ht=0.6*h0
  subseth=subset(subset,subset$N_TraitValue<ht)
  modht=lm(N_TraitValue~ResDensity,data=subseth)
  a0=modht$coefficients[2]
  summary(modht)
  #ggplot(data=subseth,aes(x=ResDensity,N_TraitValue))+geom_point()
  return(a0)
  return(h0)
}

Holling<- function(xR,a,h){
  return((a*xR)/(1+(h*a*xR)))
}
listID=40117
for (i in listID) {
  Start(subset)
  subset<-subset(data, ID==i)
  HolFit<-nlsLM(N_TraitValue ~ Holling(ResDensity, a, h), data=subset, start=list(a=h0, h=a0))
  #first need to generate x so can calc predicted ys
  Lengths<- seq(min(subset$ResDensity), max(subset$ResDensity),len=200)  #intervals min to max ###should these varyu????
  print(paste("The ID is", i))
  print(paste("a is",coef(HolFit)["a"]))
  print(paste("h is",coef(HolFit)["h"]))
  Predic2PlotHol<-Holling(Lengths,coef(HolFit)["a"], coef(HolFit)["h"])
  #Predic2PlotQua<-predict.lm(QuaFit, data.frame(TotalLength=Lengths))
  pdf(paste0("../Results/Holgraphs/",i,".pdf"))
  print(plot(subset$ResDensity,subset$N_TraitValue))
  print(lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5))
  graphics.off()
  #AICdiff<-AIC(PowFit)-AIC(QuaFit)
  #print(paste("AIC difference for", i, "is", AICdiff))
  #BICdiff<-BIC(PowFit)-BIC(QuaFit)
  #print(paste("BIC difference for", i, "is", BICdiff))
}#

####this code is v bad, fix!' 
# size<-nrow(subset)
#sizes<-c(sizes,size)
#}
#sort(sizes)

##SHOOULD I GRAB MEAN?
#model<-function(a,xR,h){
#  return((a*xR)/(1+(h*a*xR)))
#}
