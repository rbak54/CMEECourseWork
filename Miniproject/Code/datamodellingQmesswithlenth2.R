require("minpack.lm")
#require("browser")
data<-read.csv("../Data/CRatsort.csv")

Start<- function(subsetT) {
  h0=max(subsetT$N_TraitValue)
  ht=0.95*h0
  subseth<-subset(subsetT,subsetT$N_TraitValue < ht)
  if (nrow(subseth)>2) {
    modht=lm(N_TraitValue~ResDensity,data=subseth)
  } else {
    modht=lm(N_TraitValue~ResDensity,data=subsetT)
  }
  a0<-as.numeric(modht$coefficients[2])
  mat<-matrix(nrow=100,ncol=4)
  #mat<-matrix(nrow=100,ncol=3)
  
  for (k in 1:(nrow(mat))){
    #print(j)
    vala<-rnorm(1,mean=a0, 1)
    valh<-rnorm(1,mean=h0, 1)
    valq<-runif(1,min=-2,max=2)
    #valq<-0
    mat[k,1]<-vala
    mat[k,2]<-valh
    mat[k,3]<-valq
    HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h,q), data=subsetT, start=list(a=vala, h=valh, q=valq)),silent=TRUE)
    #HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=vala, h=valh)),silent=TRUE)
    if("try-error" %in% class(HolFit)){        
      #print("problem")  
    } else {
      mat[k,4]<-AIC(HolFit)
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
  #return(c(initA,initH)) }

#Holling<- function(xR,a,h,q){
 # return((a*xR)^(q+1))/(1+(h*a*xR)^(q+1))
#}
#}
Holling<- function(xR,a,h,q){
  return(((a*xR))^(q+1)/(1+((h*a*xR))^(q+1)))
}

#listID<-39871
listID<-as.numeric(unique(data$ID))
#listID<-c(39841,39839,39842)
issues<-vector()
modelqual<-matrix(nrow=length(listID),ncol=4)
j=0
for (i in listID){
  j=j+1
  modelqual[j,1]<-i
  subsetT<-subset(data, ID==i)
  out<-Start(subsetT)
  #HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h), data=subsetT, start=list(a=out[1],h=out[2])),silent=TRUE)
  HolFit<-try(nlsLM(N_TraitValue ~ Holling(ResDensity,a,h,q), data=subsetT, start=list(a=out[1],h=out[2],q=out[3])),silent=TRUE)
  pol<-lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT)
  Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
  Predic2Plotpol<- predict.lm(pol, data.frame(ResDensity=Lengths) )
  modelqual[j,3]<-AIC(pol)
  if (nrow(subsetT)>8){
    polc<-lm(N_TraitValue ~ poly(ResDensity, degree=3), data=subsetT)
    modelqual[j,4]<-AIC(polc)
    
    ##issue here
  }
  if("try-error" %in% class(HolFit)){        
    issues<-append(issues,i)
    pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
    modelqual[j,2]<-"error"
  } else {
    #   #first need to generate x so can calc predicted ys
    Predic2PlotHol<- Holling(Lengths, coef(HolFit)["a"], coef(HolFit)["h"] , coef(HolFit)["q"])
   # pdf(paste0("../Results/Holgraphs/",i,".pdf") )
    #plot(subsetT$ResDensity,subsetT$N_TraitValue) 
    #lines(Lengths,Predic2PlotHol,col="blue",lwd=2.5) 
    #lines(Lengths,Predic2Plotpol,col="red",lwd=2.5) 
    modelqual[j,2]<-AIC(HolFit)
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