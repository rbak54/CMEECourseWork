#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: datamodellingattempt.R
#Desc: data modelling with code that is no longer in use
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
require("minpack.lm")
#require("browser")

#load data
data<-read.csv("../Data/CRatsort.csv")


#function to find the best value for 
Maxlm<-function(subsetT){
  aobest<-vector()
  v=0
  
  #h0=max(subsetT$N_TraitValue)
  while (nrow(subsetT)>1){
    v=v+1#subsetbelowht
    #subsetT<-subset(subsetT, which(subsetT$N_TraitValue < h0))
  #  subsetT<-
 #     subsetT$N_TraitValue[which(max(subsetT$N_TraitValue))]
    #this is wrong!! abive- maYBE TRY WHICH
    hm<-which(subsetT$N_TraitValue[] == max(subsetT$N_TraitValue[],na.rm=TRUE))
    subsetT<-subsetT[-hm,]
    if (nrow(subsetT)>2){
  #linear model to find gradient- either for all or some values depending on number of values{
      modht=lm(N_TraitValue~ResDensity,data=subsetT)
    #h0=max(subsetT$N_TraitValue)
      #aobest[v,1]<-h0
      aobest[v]<-as.numeric(modht$coefficients[2])
    
    }
    hm<-0
  }
 # maxH<-which(aobest[]==max(aobest[]),na.)
  #mh<-aobest[maxH]
  mh<-max(aobest[],na.rm=TRUE)
  return(mh)
}
#to find initial values
Start<- function(subsetT) {
  h0=max(subsetT$N_TraitValue)
  #ht to find gradient of points below highest point
  a0=Maxlm(subsetT)
 # hm<-which(subsetT$N_TraitValue[] == max(subsetT$N_TraitValue[],na.rm=TRUE))
  #subsetT<-subsetT[-hm,]
  
  #subsetT<-subset(subsetT,subsetT$N_TraitVal < mout)
  
  ##obtain gridient from model
  #modht=lm(N_TraitValue~ResDensity,data=subsetT)
  #a0<-as.numeric(modht$coefficients[2])
  ##make matrix for initial values and aic
  mat<-matrix(nrow=200,ncol=4)
  #mat<-matrix(nrow=100,ncol=3)
  #for each row in matrix, sample around initial values and calculate model and AIC 
  
  
  for (k in 1:(nrow(mat))){
    #print(j)
    vala<-abs(rnorm(1,mean=a0, 1))
    valh<-abs(rnorm(1,mean=h0, 1))
    valq<-abs(rnorm(1,mean=1.5, 1))
    #valq<-0
    mat[k,1]<-vala
    mat[k,2]<-valh
    mat[k,3]<-valq
    HolFit<-try(nlsLM(N_TraitValue ~ HollingGEN(ResDensity,a,h,q), data=subsetT, start=list(a=vala, h=valh, q=valq), lower=c(0,0,-10)), silent=TRUE)
    #HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=vala, h=valh)),silent=TRUE)
    if("try-error" %in% class(HolFit)){        
      mat[k,4]<-"error"  
      #calculate AIC for sucessful
    } else {
      mat[k,4]<-AIC(HolFit) 
      #mat[j,3]<-AIC(HolFit)  
    }
  }
  #min(mat[,3])
  #minAIC<-which.min(mat[,3])
  #minAIC<-which(mat[,3] == min(mat[,3],na.rm=TRUE,arr.ind=TRUE))
  #find initial values with the lowest AIC
  minAIC<-which(mat[,4] == min(mat[,4],na.rm=TRUE,arr.ind=TRUE))
  
  #min(mat[,3])
  #mat<-as.data.frame(mat)
  #suub<-subset(mat,mat[,3]==min(mat[,3]))
  #capture initial values
  initA<-mat[minAIC,1]
  initH<-mat[minAIC,2]
  initQ<-mat[minAIC,3]
  #initA<-suub[1]
  #initH<-suub[2]
  #return(c(initA,initH)) }
  return(c(initA,initH,initQ)) }


Holling<- function(xR,a,h){
  return((a*xR)/(1+(h*a*xR)))
}
#}
HollingGEN<- function(xR,a,h,q){
  return(((a*xR)^(q+1))/(1+((h*a*xR)^(q+1))))
}
#
#listID<-39910
listID<-as.numeric(unique(data$ID))
#listID<-c(39841,39839,39842)
issuesH<-vector()
issuesG<-vector()
issuesPC<-vector()
issuesP<-vector()
modelqual<-matrix(nrow=length(listID),ncol=5)
modelqualb<-matrix(nrow=length(listID),ncol=5)

j=0
Best<-matrix(ncol=5,nrow=length(listID))
for (i in listID){
  j=j+1
  modelqual[j,1]<-i
  modelqualb[j,1]<-i
  
  subsetT<-subset(data, ID==i)
  colnames(modelqual)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  colnames(modelqualb)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  #starting values
  out<-Start(subsetT)
  #model fitting
  HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=out[1],h=out[2]),lower=c(0,0)),silent=TRUE)
  HolFitGEN<-try(nlsLM(N_TraitValue ~ HollingGEN(ResDensity,a,h,q), data=subsetT, start=list(a=out[1],h=out[2],q=out[3]),lower=c(0,0,-10)),silent=TRUE)
  pol<-try(lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT), silent=TRUE)
  polc<-try(lm(N_TraitValue ~ poly(ResDensity, degree=3), data=subsetT),silent=TRUE)
  Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
  pdf(paste0("../Results/Holgraphs/",i,".pdf") )
  plot(subsetT$ResDensity,subsetT$N_TraitValue) 
  if(!("try-error" %in% class(polc))){
    #   &(AIC(polc)!="-Inf")){
    Predic2Plotpolc<- predict.lm(polc, data.frame(ResDensity=Lengths) )
    lines(Lengths,Predic2Plotpolc,col="#FF6600",lwd=2.5) 
    if (AIC(polc)!=-Inf){
      modelqual[j,5]<-AIC(polc)}
    if (BIC(polc)!=-Inf){
      modelqualb[j,5]<-BIC(polc)}
    
    #modelqualb[j,5]<-BIC(polc)
  }else{
    issuesPC<-append(issuesPC,i)
    modelqual[j,5]<-"NA"
    modelqualb[j,5]<-"NA"
    
  }
  if("try-error" %in% class(pol)){
    issuesP<-append(issuesP,i)
    modelqual[j,4]<-"NA"
    modelqualb[j,4]<-"NA"
    
  }else{
    Predic2Plotpol<- predict.lm(pol, data.frame(ResDensity=Lengths) )
    lines(Lengths,Predic2Plotpol,col="red",lwd=2.5)
    modelqual[j,4]<-AIC(pol)
    modelqualb[j,4]<-BIC(pol)
    
  }
  if("try-error" %in% class(HolFit)){        
    issuesH<-append(issuesH,i)
    modelqual[j,2]<-"NA"
    modelqualb[j,2]<-"NA"
    
  } else {
    #   #first need to generate x so can calc predicted ys
    Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"])
    # pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    #plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    
    lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5) 
    modelqual[j,2]<-AIC(HolFit)
    modelqualb[j,2]<-BIC(HolFit)
    
    #lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
  }
  if("try-error" %in% class(HolFitGEN)){        
    issuesG<-append(issuesG,i)
    #pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    #plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    #lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
    modelqual[j,3]<-"NA"
    modelqualb[j,3]<-"NA"
    
  } else {
    #   #first need to generate x so can calc predicted ys
    Predic2PlotHolGEN<- HollingGEN(Lengths, coef(HolFitGEN)["a"], coef(HolFitGEN)["h"] , coef(HolFitGEN)["q"])
    lines(Lengths,Predic2PlotHolGEN,col="green",lwd=2.5)
    # pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    #plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    #lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
    modelqual[j,3]<-AIC(HolFitGEN)  
    modelqualb[j,3]<-BIC(HolFitGEN)  
    
  }
  graphics.off()
  ##try to move into above loop?
  #s=0
  #for (l in listID) {
  #s=s+1
  Best[j,1]<-i
  #t<-which(modelqual[,1]==l)
  #print(t)
  # Best[s,2]<-
  ###not callign correct valye
  t<-which(modelqual[,1]==i)
  u<-which(modelqualb[,1]==i)
  Best[j,2]<- which(modelqual[t,2:5]==min(as.numeric(modelqual[t,2:5]),na.rm = TRUE))
  Best[j,4]<- which(modelqualb[u,2:5]==min(as.numeric(modelqualb[u,2:5]),na.rm=TRUE))
  
  #na.rm=TRUE, arr.ind=TRUE)
  #Best[j,2]<- which(modelqual[j,2:5]==a), na.rm=TRUE, arr.ind=FALSE))
  
  Best[j,3]<-min(as.numeric(modelqual[t,2:5]),na.rm=TRUE)
  Best[j,5]<-min(as.numeric(modelqualb[u,2:5]),na.rm=TRUE)
  
  #this isnt working bc l isn't an index
  #  }
}

write.csv(Best,"../Results/CRatBest.csv")

#minAIC<-which(mat[,4] == min(mat[,4],na.rm=TRUE,arr.ind=TRUE))

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