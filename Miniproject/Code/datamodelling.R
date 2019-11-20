require("minpack.lm")
#require("browser")
data<-read.csv("../Data/CRatsort.csv")

Start<- function(subsetT) {
      h0=max(subsetT$N_TraitValue)
      ht=h0
      subseth<-subset(subsetT,subsetT$N_TraitValue < ht)
      if (nrow(subseth)>2) {
          modht=lm(N_TraitValue~ResDensity,data=subseth)
  # #  print("sethok")
          } else {
  #   #summary(modht)
      modht=lm(N_TraitValue~ResDensity,data=subsetT)}
  #  ## j<-j+1
  # #  print("notseth")
   #}
      a0<-as.numeric(modht$coefficients[2])
  #both<-c(a0,h0)
  #ggplot(data=subseth,aes(x=ResDensity,N_TraitValue))+geom_point()
  #return(both)
      mat<-matrix(nrow=100,ncol=3)
      for (j in 1:(nrow(mat))){
          vala<-rnorm(1,mean=a0, 1) ###but what if negative
          valh<-rnorm(1,mean=h0, 1)
          mat[j,1]<-vala
          mat[j,2]<-valh
          try(HolFit<-nlsLM(N_TraitValue ~ Holling(ResDensity, a, h), data=subsetT, start=list(a=vala, h=valh)),silent = FALSE)
          mat[j,3]<-AIC(HolFit)}
      #min(mat[,3])
      #minAIC<-which.min(mat[,3])
      #minAIC<-which(mat[,3] == min(mat[,3],na.rm=TRUE,arr.ind=TRUE))
      #min(mat[,3])
      mat<-as.data.frame(mat)
      suub<-subset(mat,mat[,3]==min(mat[,3]))
      #initA<-mat[minAIC,1]
      #initH<-mat[minAIC,2]
      initA<-suub[1]
      initH<-suub[2]
      return(c(initA,initH))}


Holling<- function(xR,a,h){
  return((a*xR)/(1+(h*a*xR)))
}
#listID<-39842
listID<-unique(data$ID)
#listID<-c(39841,39839,39842)
for (i in listID){
  subsetT<-subset(data, ID==i)
  out<-Start(subsetT)
  HolFit<-nlsLM(N_TraitValue ~ Holling(ResDensity, a, h), data=subsetT, start=list(a=out[1],h=out[2]))
  pol<-lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT)
  #HolFit<-nlsLM(N_TraitValue ~ Holling(ResDensity, a, h), data=subsetT, start=list(a=both[1], h=both[2]), )
  #   #first need to generate x so can calc predicted ys
  Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
  #intervals min to max ###should these varyu????
  #   #print(paste("The ID is", i))
  #   #print(paste("a is",coef(HolFit)["a"]))
  #   #print(paste("h is",coef(HolFit)["h"]))
  Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"] )
  Predic2Plotpol<- predict.lm(pol, data.frame(ResDensity=Lengths) )
  #Predic2PlotQua<-predict.lm(QuaFit, data.frame(TotalLength=Lengths))
  pdf(paste0("../Results/Holgraphs/",i,".pdf") )
  print(plot(subsetT$ResDensity,subsetT$N_TraitValue) )
  print(lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5) )
  print(lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) )
  
  graphics.off()
#     #AICdiff<-AIC(PowFit)-AIC(QuaFit)
#     #print(paste("AIC difference for", i, "is", AICdiff))
#     #BICdiff<-BIC(PowFit)-BIC(QuaFit)
#     #print(paste("BIC difference for", i, "is", BICdiff))
}
#
# ####this code is v bad, fix!'
# # size<-nrow(subset)
# #sizes<-c(sizes,size)
# #}
# #sort(sizes)
#
# ##SHOOULD I GRAB MEAN?
# #model<-function(a,xR,h){
# #  return((a*xR)/(1+(h*a*xR)))
# #}
# for (j in 1:(nrow(mat))){
#   vala<-rnorm(1,out[1], 1)
#   valh<-rnorm(1,out[2], 1)
#   mat[j,1]<-vala
#   mat[j,2]<-valh
#   HolFit<-nlsLM(N_TraitValue ~ Holling(ResDensity, a, h), data=subsetT, start=list(a=vala, h=valh))
#   mat[j,3]<-AIC(HolFit)
#   return(mat)
# }
