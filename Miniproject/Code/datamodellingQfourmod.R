require("minpack.lm")
#require("browser")


data<-read.csv("../Data/CRatsort.csv")


#to find initial values
Start<- function(subsetT) {
  h0=max(subsetT$N_TraitValue)
  #ht to find gradient of points below highest point
  ht=0.95*h0
  #subsetbelowht
  subseth<-subset(subsetT,subsetT$N_TraitValue < ht)
    #linear model to find gradient- either for all or some values depending on number of values
    if (nrow(subseth)>2) {
    modht=lm(N_TraitValue~ResDensity,data=subseth)
    #linear model for all values to find gradient if very few values
    } else {
    modht=lm(N_TraitValue~ResDensity,data=subsetT) }
  
  ##obtain gridient from model
  a0<-as.numeric(modht$coefficients[2])
  ##make matrix for initial values and aic
  mat<-matrix(nrow=100,ncol=4)
  #mat<-matrix(nrow=100,ncol=3)
  #for each row in matrix, sample around initial values and calculate model and AIC 
  for (k in 1:(nrow(mat))){
    #print(j)
    vala<-rnorm(1,mean=a0, 1)
    valh<-rnorm(1,mean=h0, 1)
    valq<-runif(1,min=-2,max=2)
    #valq<-0
    mat[k,1]<-vala
    mat[k,2]<-valh
    mat[k,3]<-valq
    HolFit<-try(nlsLM(N_TraitValue ~ HollingGEN(ResDensity,a,h,q), data=subsetT, start=list(a=vala, h=valh, q=valq)),silent=TRUE)
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
  return(((a*xR))^(q+1)/(1+((h*a*xR))^(q+1)))
}

#listID<-2
listID<-as.numeric(unique(data$ID))
#listID<-c(39841,39839,39842)
issuesH<-vector()
issuesG<-vector()
issuesPC<-vector()
issuesP<-vector()
modelqual<-matrix(nrow=length(listID),ncol=5)
j=0
for (i in listID){
  j=j+1
  modelqual[j,1]<-i
  subsetT<-subset(data, ID==i)
  colnames(modelqual)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  #starting values
  out<-Start(subsetT)
  #model fitting
  HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=out[1],h=out[2])),silent=TRUE)
  HolFitGEN<-try(nlsLM(N_TraitValue ~ HollingGEN(ResDensity,a,h,q), data=subsetT, start=list(a=out[1],h=out[2],q=out[3])),silent=TRUE)
  pol<-try(lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT), silent=TRUE)
  polc<-try(lm(N_TraitValue ~ poly(ResDensity, degree=3), data=subsetT),silent=TRUE)
  Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
  pdf(paste0("../Results/Holgraphs/",i,".pdf") )
  plot(subsetT$ResDensity,subsetT$N_TraitValue) 
  if("try-error" %in% class(polc)){
    issuesPC<-append(issuesPC,i)
    modelqual[j,5]<-"NA"
    }else{
    Predic2Plotpolc<- predict.lm(pol, data.frame(ResDensity=Lengths) )
    lines(Lengths,Predic2Plotpolc,col="#FF6600",lwd=2.5) 
    modelqual[j,5]<-AIC(polc)
    }
  if("try-error" %in% class(pol)){
    issuesP<-append(issuesP,i)
    modelqual[j,4]<-"NA"
  }else{
    Predic2Plotpol<- predict.lm(pol, data.frame(ResDensity=Lengths) )
    lines(Lengths,Predic2Plotpol,col="red",lwd=2.5)
    modelqual[j,4]<-AIC(pol)
  }
  if("try-error" %in% class(HolFit)){        
    issuesH<-append(issuesH,i)
    modelqual[j,2]<-"NA"
  } else {
    #   #first need to generate x so can calc predicted ys
    Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"])
    # pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    #plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    
    lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5) 
    modelqual[j,2]<-AIC(HolFit)
    #lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
  }
if("try-error" %in% class(HolFitGEN)){        
    issuesG<-append(issuesG,i)
    #pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    #plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    #lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
    modelqual[j,3]<-"NA"
  } else {
    #   #first need to generate x so can calc predicted ys
    Predic2PlotHolGEN<- HollingGEN(Lengths, coef(HolFitGEN)["a"], coef(HolFitGEN)["h"] , coef(HolFitGEN)["q"])
    # pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    #plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    #lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
    modelqual[j,3]<-AIC(HolFitGEN)  
    lines(Lengths,Predic2PlotHolGEN,col="green",lwd=2.5) 

  }
  graphics.off()
  #Best<-matrix(ncol=3,nrow=length(listID))
  ##try to move into above loop?
  #s=0
 #f#or (l in listID) {
    #s=s+1
    #Best[s,1]<-l
    #t<-which(modelqual[,1]==l)
    #print(t)
   # Best[s,2]<-
   # Best[s,2]<- which(modelqual[t,2:4]==min(modelqual[t,2:4],na.rm=TRUE, arr.ind=TRUE))
    #Best[s,3]<-min(modelqual[t,2:4])
    #this isnt working bc l isn't an index
#  }
}
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