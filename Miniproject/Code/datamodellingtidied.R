#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: datamodellingtidied.R
#Desc: best version of data modelling
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
require("minpack.lm")

#load data
data<-read.csv("../Data/CRatsort.csv")


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
    hm<-which(subsetT$N_TraitValue[] == max(subsetT$N_TraitValue[],na.rm=TRUE))
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
#function to find initial values for a0,h0 and q
Start<- function(subsetT) {
  h0=max(subsetT$N_TraitValue)
  #fun function to calculate steepest gradient
  a0=Maxlm(subsetT)
  ##make matrix for initial values and aic
  mat<-matrix(nrow=200,ncol=4)
  #for each row in matrix, sample around initial values and calculate AIC 
  for (k in 1:(nrow(mat))){
    vala<-abs(rnorm(1,mean=a0, 1))
    valh<-abs(rnorm(1,mean=h0, 1))
    valq<-rnorm(1,mean=0, 1)
    #valq<-runif(1,-5,5)
    
    mat[k,1]<-vala
    mat[k,2]<-valh
    mat[k,3]<-valq
    HolFitS<-try(nlsLM(N_TraitValue ~ HollingGEN(ResDensity,a,h,q), data=subsetT, start=list(a=vala, h=valh, q=valq), lower=c(0,0,-10),control = list(maxiter=100)), silent=TRUE)
    #HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=vala, h=valh)),silent=TRUE)
    if("try-error" %in% class(HolFitS)){        
      mat[k,4]<-"error"  
      #calculate AIC for sucessful
    } else {
      mat[k,4]<-AIC(HolFitS) 
    }
  }
  #find initial values with the lowest AIC
  minAIC<-which(mat[,4] == min(mat[,4],na.rm=TRUE,arr.ind=TRUE))
  
  initA<-mat[minAIC,1]
  initH<-mat[minAIC,2]
  initQ<-mat[minAIC,3]
  
  return(c(initA,initH,initQ)) }
#holling and generalised holling functions
Holling<- function(xR,a,h){
  return((a*xR)/(1+(h*a*xR)))
}
HollingGEN<- function(xR,a,h,q){
  return((a*xR^(q+1))/(1+(h*a*xR^(q+1))))
}
#listID<-39855
listID<-as.numeric(unique(data$ID))
#listID<-c(39841,39839,39842)
#make empty vectors for errors- can probably remove this
issuesH<-vector()
issuesG<-vector()
issuesPC<-vector()
issuesP<-vector()
#matrix for model aic values
modelqual<-matrix(nrow=length(listID),ncol=5)
#matrix for model bic values    
modelqualb<-matrix(nrow=length(listID),ncol=5)
j=0
#matrix for id, best model and value of aic or bic (best model depending on whether AIC or BIC is used)
Best<-matrix(ncol=5,nrow=length(listID))
#for each of different IDs
#j used to index each of list id
for (i in listID){
  j=j+1
  modelqual[j,1]<-i
  modelqualb[j,1]<-i
  #subset data
  subsetT<-subset(data, ID==i)
  colnames(modelqual)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  colnames(modelqualb)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  #starting values
  out<-Start(subsetT)
  #model fitting
  HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=out[1],h=out[2]),lower=c(0,0),control = list(maxiter=100)),silent=TRUE)
  HolFitGEN<-try(nlsLM(N_TraitValue ~ HollingGEN(ResDensity,a,h,q), data=subsetT, start=list(a=out[1],h=out[2],q=out[3]),lower=c(0,0,-10),control = list(maxiter=1000)),silent=TRUE)
  pol<-try(lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT), silent=TRUE)
  polc<-try(lm(N_TraitValue ~ poly(ResDensity, degree=3), data=subsetT),silent=TRUE)
  #x values for model plotting
  Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
  #make empty pdf for each ID
  pdf(paste0("../Results/Holgraphs/",i,".pdf") )
  plot(subsetT$ResDensity,subsetT$N_TraitValue) 
  #if error in model-then NA in table, otherwise plot and put AIC and BIC in tables
  #polc
  if(!("try-error" %in% class(polc))){
    Predic2Plotpolc<- predict.lm(polc, data.frame(ResDensity=Lengths) )
    lines(Lengths,Predic2Plotpolc,col="#FF6600",lwd=2.5) 
    #only use values that are finite
    if (AIC(polc)!=-Inf){
      modelqual[j,5]<-AIC(polc)}
    if (BIC(polc)!=-Inf){
      modelqualb[j,5]<-BIC(polc)}
      }else{
    issuesPC<-append(issuesPC,i)
    modelqual[j,5]<-"NA"
    modelqualb[j,5]<-"NA"
    #pol
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
    #holling
  }
  if("try-error" %in% class(HolFit)){        
    issuesH<-append(issuesH,i)
    modelqual[j,2]<-"NA"
    modelqualb[j,2]<-"NA"
  } else {
    Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"])
    lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5) 
    modelqual[j,2]<-AIC(HolFit)
    modelqualb[j,2]<-BIC(HolFit)
    ##generalised holling
      }
  if("try-error" %in% class(HolFitGEN)){        
    issuesG<-append(issuesG,i)
    modelqual[j,3]<-"NA"
    modelqualb[j,3]<-"NA"
    
  } else {
    Predic2PlotHolGEN<- HollingGEN(Lengths, coef(HolFitGEN)["a"], coef(HolFitGEN)["h"] , coef(HolFitGEN)["q"])
    lines(Lengths,Predic2PlotHolGEN,col="green",lwd=2.5)
    modelqual[j,3]<-AIC(HolFitGEN)  
    modelqualb[j,3]<-BIC(HolFitGEN)  
  }
  graphics.off()
#find best values for modelqual and modelqual b. then put in matrix
  Best[j,1]<-i
  t<-which(modelqual[,1]==i)
  u<-which(modelqualb[,1]==i)
  Best[j,2]<- which(modelqual[t,2:5]==min(as.numeric(modelqual[t,2:5]),na.rm = TRUE))
  Best[j,4]<- which(modelqualb[u,2:5]==min(as.numeric(modelqualb[u,2:5]),na.rm=TRUE))
  
  Best[j,3]<-min(as.numeric(modelqual[t,2:5]),na.rm=TRUE)
  Best[j,5]<-min(as.numeric(modelqualb[u,2:5]),na.rm=TRUE)
}

write.csv(Best,"../Results/CRatBest.csv")