#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: modelfittingfunctions.R
#Desc: model fitting script
#Arguments: none
#Input: none 
#Output: none
#Date: march 2020

#FUNCTIONS
#function to find the steepest possible curve
Maxlm<-function(subsetT){
  #empty vector to collect coefficients for linear model
  aobest<-vector()
  v=1
  #run lm for all data and store results in abobest
  modht=lm(N_TraitValue~ResDensity,data=subsetT)
  aobest[v]<-as.numeric(modht$coefficients[2])
  #find hm(maximum value) and remove this value. if sufficient, run lm and store coefficients
  while (nrow(subsetT)>1){
    v=v+1
    #  hm<-which(subsetT$N_TraitValue[] == max(subsetT$N_TraitValue[],na.rm=TRUE))
    # subsetT<-subsetT[-hm,]
    hm<-which(subsetT$ResDensity[] == max(subsetT$ResDensity[],na.rm=TRUE))
    subsetT<-subsetT[-hm,]
    if (nrow(subsetT)>2){
      modht=lm(N_TraitValue~ResDensity,data=subsetT)
      aobest[v]<-as.numeric(modht$coefficients[2])
    }
    #delete values for hm
    hm<-0
  }
  #find largest coefficient
  mh<-max(aobest[],na.rm=TRUE)
  return(mh)
}

#function to find initial values for a0,h0

StartII<- function(subsetT) {
  h0=max(subsetT$N_TraitValue)
  #fun function to calculate steepest gradient
  a0=Maxlm(subsetT)
  ##make matrix for initial values and aic  
  mat<-matrix(nrow=100,ncol=3)
  #for each row in matrix, sample around initial values and calculate AIC 
  for (k in 1:(nrow(mat))){
    vala<-abs(rnorm(1,mean=a0, 1))
    valh<-abs(rnorm(1,mean=h0, 1))
    mat[k,1]<-vala
    mat[k,2]<-valh
    HolFitII_s<-try(nlsLM(N_TraitValue ~ HollingII(ResDensity,a,h), data=subsetT, start=list(a=vala, h=valh), lower=c(0,0),control = list(maxiter=1000)),silent=TRUE)
    #HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=vala, h=valh)),silent=TRUE)
    if("try-error" %in% class(HolFitII_s)){        
      mat[k,3]<-NA 
      #calculate AIC for sucessful
    } else {
      mat[k,3]<-AIC(HolFitII_s) 
    }
  }
  #find initial values with the lowest AIC
  minAIC<-which(mat[,3] == min(mat[,3],na.rm=TRUE,arr.ind=TRUE))
  initA<-mat[minAIC,1]
  initH<-mat[minAIC,2]
  
  return(c(initA,initH)) }

StartIII<- function(subsetT) {
  h0=max(subsetT$N_TraitValue)
  #fun function to calculate steepest gradient
  a0=Maxlm(subsetT)
  ##make matrix for initial values and aic  
  mat<-matrix(nrow=100,ncol=4)
  #for each row in matrix, sample around initial values and calculate AIC 
  for (k in 1:(nrow(mat))){
    vala<-abs(rnorm(1,mean=a0, 1))
    valh<-abs(rnorm(1,mean=h0, 1))
    #    valq<-abs(rnorm(1,mean=1, )
    #valq<-1
    valq<-runif(1,-2,2)
    mat[k,1]<-vala
    mat[k,2]<-valh
    mat[k,3]<-valq
    HolFitIII_s<-try(nlsLM(N_TraitValue ~ HollingIII(ResDensity,a,h,q), data=subsetT, start=list(a=vala, h=valh, q=valq), lower=c(0,0,-50),control = list(maxiter=1000)), silent=TRUE)
    #HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=vala, h=valh)),silent=TRUE)
    if("try-error" %in% class(HolFitIII_s)){        
      mat[k,4]<-NA  
      #calculate AIC for sucessful
    } else {
      mat[k,4]<-AIC(HolFitIII_s)
    }
  }
  #find initial values with the lowest AIC
  minAIC<-which(mat[,4] == min(mat[,4],na.rm = T,arr.ind=TRUE))
  initA<-mat[minAIC,1]
  initH<-mat[minAIC,2]
  initQ<-mat[minAIC,3]
  return(c(initA,initH,initQ)) }


#holling and generalised holling functions
HollingII<- function(xR,a,h){
  return((a*xR)/(1+(h*a*xR)))
}
HollingIII<- function(xR,a,h,q){
  return((a*xR^(q+1))/(1+(h*a*xR^(q+1))))
}
