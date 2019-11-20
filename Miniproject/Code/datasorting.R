require("minpack.lm")

data<-read.csv("../Data/CRat.csv")
#add<-vector(length=nrow(data))
data$a0=NA
data$h0=NA
listID<-unique(data$ID)
Holling<- function(xR,a,h){
  return((a*xR)/(1+(h*a*xR)))
}
#subset<-subset(data,ID==2)
#  ggplot(data=subset,aes(x=ResDensity,N_TraitValue))+geom_point()
#s#izes<-vector()
for (i in listID) {
  subset<-subset(data, ID==i)
  subset<-subset[!is.na(subset$ResDensity),]  ##removing naS  
  subset<-subset[!is.na(subset$N_TraitValue),]
  size<-nrow(subset)
  if (size > 3) {
    #plotting
    #pdf(paste0("../Results/initgraphs/", i, ".pdf"))# Open blank pdf page using a relative path
    #print(ggplot(data=subset,aes(x=ResDensity,N_TraitValue))+geom_point())
    #graphics.off()
    ####FIT! see egs below
    HolFit<-nlsLM(N_TraitValue ~ Holling(ResDensity, a, h), data=subset, start=list(a=.1, h=.1))
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
  }
}
 ####this code is v bad, fix!' 
  # size<-nrow(subset)
  #sizes<-c(sizes,size)
#}
#sort(sizes)

##SHOOULD I GRAB MEAN?
#model<-function(a,xR,h){
#  return((a*xR)/(1+(h*a*xR)))
#}
