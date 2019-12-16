#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: datamodellingtidied.R
#Desc: best version of data modelling
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
rm(list=ls())
graphics.off()
require("minpack.lm")

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
    #valq<-rnorm(1,mean=0, 1)
    valq<-runif(1,-5,5)
    
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

#load data
data<-read.csv("../Data/CRatsort.csv")

listID<-as.numeric(unique(data$ID))
#make empty vectors for errors- can probably remove this +++
issuesH<-vector()
issuesG<-vector()
issuesPC<-vector()
issuesP<-vector()
#add new column rows- +++
data[c("Holling_AIC","Holling_gen_AIC","Poly_2_AIC","Poly_3_AIC","Holling_BIC","Holling_gen_BIC","Poly_2_BIC","Poly_3_BIC","BestAIC","BestBIC")]<-NA #"Holling_adjR","Holling_gen_adjR","Poly_2_adjR","Poly_3_adjR"
j=0
#make a version of data with only one row for each ID
datashort<-data[!duplicated(data[,"ID"]),]

dir.create("../Results/Holgraphs")
#for each of different IDs
#j used to index each of list id
for (i in listID){
  j=j+1
  #modelqual[j,1]<-i
  #modelqualb[j,1]<-i
  #subset data
  subsetT<-subset(data, ID==i)
  #colnames(modelqual)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  #colnames(modelqualb)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  #starting values
  out<-Start(subsetT)
  datashort[j,"a0"]<-out[1]
  datashort[j,"h0"]<-out[2]
  datashort[j,"q0"]<-out[3]
  ##if energu, could try to add to function with data and i as input
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
     # data[i,"Poly_3_adjR"]<-summary(polc)$adj.r.squared
      #only use values that are finite
    if (AIC(polc)!=-Inf){
      datashort[j,"Poly_3_AIC"]<-AIC(polc)}
    if (BIC(polc)!=-Inf){
       datashort[j,"Poly_3_BIC"]<-BIC(polc)}
  }else{
    issuesPC<-append(issuesPC,i)}
  if("try-error" %in% class(pol)){
    issuesP<-append(issuesP,i)
  }else{
    Predic2Plotpol<- predict.lm(pol, data.frame(ResDensity=Lengths) )
    lines(Lengths,Predic2Plotpol,col="red",lwd=2.5)
    datashort[j,"Poly_2_AIC"]<-AIC(pol)
    datashort[j,"Poly_2_BIC"]<-BIC(pol)
    #data[i,"Poly_2_adjR"]<-summary(pol)$adj.r.squared
    }
    #hollin
  if("try-error" %in% class(HolFit)){        
    issuesH<-append(issuesH,i)
  } else {
    Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"])
    lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5) 
   datashort[j,"Holling_AIC"]<-AIC(HolFit)
   datashort[j,"Holling_BIC"]<-BIC(HolFit)
   #data[i,"Holling_adjR"]<-summary(HolFit)$adj.r.squared
   }
    ##generalised holling
  if("try-error" %in% class(HolFitGEN)){        
    issuesG<-append(issuesG,i)
    
  } else {
    Predic2PlotHolGEN<- HollingGEN(Lengths, coef(HolFitGEN)["a"], coef(HolFitGEN)["h"] , coef(HolFitGEN)["q"])
    lines(Lengths,Predic2PlotHolGEN,col="green",lwd=2.5)
    datashort[j,"Holling_gen_AIC"]<-AIC(HolFitGEN)
    datashort[j,"Holling_gen_BIC"]<-BIC(HolFitGEN)
  #  data[i,"Holling_gen_adjR"]<-summary(HolFitGEN)$adj.r.squared
  }
  graphics.off()

  }
#2 holling ,3 gen holling ,4 pol(polnomial degree2), 5,polc (polynomal degree3)
write.csv(datashort,"../Results/CRatdatashort.csv")


#no adj R for nlls
#rss?