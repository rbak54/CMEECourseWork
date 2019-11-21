require("minpack.lm")
#require("browser")
data<-read.csv("../Data/CRatsort.csv")

Start<- function(subsetT) {
      h0=max(subsetT$N_TraitValue)
      ht=0.95*h0
      subseth<-subset(subsetT,subsetT$N_TraitValue < ht)
      if (nrow(subseth)>3) {
          modht=lm(N_TraitValue~ResDensity,data=subseth)
          } else {
          modht=lm(N_TraitValue~ResDensity,data=subsetT)
          }
      a0<-as.numeric(modht$coefficients[2])
      mat<-matrix(nrow=1000,ncol=4)
      #mat<-matrix(nrow=100,ncol=3)
      
      for (j in 1:(nrow(mat))){
          #print(j)
          vala<-rnorm(1,mean=a0, 1)
          valh<-rnorm(1,mean=h0, 1)
          valq<-runif(1,min=-2,max=2)
          #valq<-0
          mat[j,1]<-vala
          mat[j,2]<-valh
          mat[j,3]<-valq
          HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h,q), data=subsetT, start=list(a=vala, h=valh, q=valq)),silent=TRUE)
#          HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=vala, h=valh)),silent=TRUE)
          if("try-error" %in% class(HolFit)){        
           #print("problem")  
          } else {
            mat[j,4]<-AIC(HolFit)
            #mat[j,3]<-AIC(HolFit)
            
          }
      }
          #min(mat[,3])
          #minAIC<-which.min(mat[,3])
      #minAIC<-which(mat[,3] == min(mat[,3],na.rm=TRUE,arr.ind=TRUE))
      minAIC<-which(mat[,4] == min(mat[,4],na.rm=TRUE,arr.ind=TRUE))
      
                #min(mat[,3])
      #mat<-as.data.frame(mat)
      #suub<-subset(mat,mat[,3]==min(mat[,3]))
      initA<-mat[minAIC,1]
      initH<-mat[minAIC,2]
      initQ<-mat[minAIC,3]
      #initA<-suub[1]
      #initH<-suub[2]
      #return(c(initA,initH)) }
      return(c(initA,initH,initQ)) }

#Holling<- function(xR,a,h,q){
#  return((a*xR)^(q+1))/(1+(h*a*xR)^(q+1))
#}
#}
Holling<- function(xR,a,h,q){
  return(((a*xR))^(q+1)/(1+((h*a*xR))^(q+1)))
}



#listID<-39871
listID<-as.numeric(unique(data$ID))
#listID<-c(39841,39839,39842)
issues<-vector()
for (i in listID){
  subsetT<-subset(data, ID==i)
  out<-Start(subsetT)
  #print(out)
  #HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=out[1],h=out[2])),silent=TRUE)
    HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h,q), data=subsetT, start=list(a=out[1],h=out[2],q=out[3])),silent=TRUE)
  if("try-error" %in% class(HolFit)){        
    issues<-append(issues,i)
    pol<-lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT)
    Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
    Predic2Plotpol<- predict.lm(pol, data.frame(ResDensity=Lengths) )
    pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
  } else {
    pol<-lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT)
    #HolFit<-nlsLM(N_TraitValue ~ Holling(ResDensity, a, h), data=subsetT, start=list(a=both[1], h=both[2]), )
    #   #first need to generate x so can calc predicted ys
    Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
    #intervals min to max ###should these varyu????
    #   #print(paste("The ID is", i))
    #   #print(paste("a is",coef(HolFit)["a"]))
    #   #print(paste("h is",coef(HolFit)["h"]))
    Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"] , coef(HolFit)["q"])
    #Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"])
    
    Predic2Plotpol<- predict.lm(pol, data.frame(ResDensity=Lengths) )
    #Predic2PlotQua<-predict.lm(QuaFit, data.frame(TotalLength=Lengths))
    pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5) 
    lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
    
  }
  graphics.off()
 }

#     #AICdiff<-AIC(PowFit)-AIC(QuaFit)
#     #print(paste("AIC difference for", i, "is", AICdiff))
#     #BICdiff<-BIC(PowFit)-BIC(QuaFit)
#     #print(paste("BIC difference for", i, "is", BICdiff))
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
#This works! 20 where doesn't.' remove? then compare with polyomial for eACH ? AIC