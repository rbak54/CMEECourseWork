#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: modelfitting.R
#Desc: model fitting script
#Arguments: none
#Input: none 
#Output: none
#Date: march 2020


#qse needs to add to python if keep
graphics.off()
require("minpack.lm")


source("./modelfittingfunctions.R")
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
#load data
data<-read.csv("../Data/CRatsort.csv")
#listID<-39835
#MOVE THIS 
data$hIIp<-NA
data$hIIIp<-NA
data$aIp<-NA
data$aIIp<-NA
data$aIIIp<-NA
data$qIIIp<-NA
listID<-as.numeric(unique(data$ID))
#add new column rows- +++ should this be in python file
#data[,c("HollingI_AIC","HollingII_AIC","HollingIII_AIC","Poly2_AIC","Poly3_AIC","N","FailHolI","FailHolII","FailHolIII","FailPol2","FailPol3","aI","aII","hII","aIII","hIII","qIII")]<-NA #"Holling_adjR","Holling_gen_adjR","Poly_2_adjR","Poly_3_adjR"
j=0
#make a version of data with only one row for each ID
datashort<-data[!duplicated(data[,"ID"]),]
if (dir.exists("../Results/Plots")==FALSE){
  dir.create("../Results/Plots")
}
#for each of different IDs
#j used to index each of list id

for (i in listID){
  j=j+1
  #modelqual[j,1]<-i
  #modelqualb[j,1]<-i
  #subset data
  subsetT<-subset(data, ID==i)
  n<-nrow(subsetT)
  #colnames(modelqual)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  #colnames(modelqualb)<-c("ID","Holling","Holling_General","Pol_Quadratic","Pol_Cubic")
  #starting values
  outII<-StartII(subsetT)
  outIII<-StartIII(subsetT)
  
  ##if energu, could try to add to function with data and i as input
  #model fitting
  HolFitII<-try(nlsLM(N_TraitValue ~ HollingII(ResDensity,a,h), data=subsetT, start=list(a=outII[1],h=outII[2]),lower=c(0,0),control = list(maxiter=1000)),silent=TRUE)
  HolFitIII<-try(nlsLM(N_TraitValue ~ HollingIII(ResDensity,a,h,q), data=subsetT, start=list(a=outIII[1],h=outIII[2],q=outIII[3]),lower=c(0,0,-50),control = list(maxiter=1000)),silent=TRUE)
  HolFitI<-try(lm(N_TraitValue ~ ResDensity, data=subsetT), silent=TRUE)
  pol2<-try(lm(N_TraitValue ~ poly(ResDensity, degree=2), data=subsetT), silent=TRUE)
  pol3<-try(lm(N_TraitValue ~ poly(ResDensity, degree=3), data=subsetT),silent=TRUE)
  #x values for model plotting
  datashort[j,"N"]<-n
  datashort[j,"a0_I"]<-HolFitI$coefficients[2]
  datashort[j,"a0_II"]<-outII[1]
  datashort[j,"h0_II"]<-outII[2]
  datashort[j,"a0_III"]<-outIII[1]
  datashort[j,"h0_III"]<-outIII[2]
  datashort[j,"q0_III"]<-outIII[3]
  
    Lengths<- seq(min(subsetT$ResDensity), max(subsetT$ResDensity),len=200)  
    #make empty pdf for each ID
    png(paste0("../Results/Plots/",i,".png") )
    plot(subsetT$ResDensity,subsetT$N_TraitValue,type="p",main=paste("ID:",i), xlab="Resource Density",ylab="Resources Consumed") 
    legend("topleft", legend=c("Holling Type I", "Holling Type II","Holling Type III","Degree 2 Polynomial","Degree 3 Polynomial"),
           col=c(cbbPalette[3],cbbPalette[2],cbbPalette[5],cbbPalette[6], cbbPalette[4]), lty=1,cex=1)
    #if error in model-then NA in table, otherwise plot and put AIC and BIC in tables
    #polc
    
    if(!("try-error" %in% class(pol3))){
      Predict_pol3<- predict.lm(pol3, data.frame(ResDensity=Lengths) )
      lines(Lengths,Predict_pol3,col=cbbPalette[4],lwd=2.5) 
      #only use values that are finite
      if (AIC(pol3)!=-Inf){
        datashort[j,"Poly3_AIC"]<-AIC(pol3)}
    }else{
      datashort[j,"FailPol3"]<-1
    }
    if("try-error" %in% class(pol2)){
      datashort[j,"FailPol2"]<-1
    }else{
      Predict_pol2<- predict.lm(pol2, data.frame(ResDensity=Lengths) )
      lines(Lengths,Predict_pol2,col=cbbPalette[6],lwd=2.5)
      datashort[j,"Poly2_AIC"]<-AIC(pol2)
    }
    #hollin
    if("try-error" %in% class(HolFitI)){        
      datashort[j,"FailHolI"]<-1
    } else {
      Predict_HolI<-predict.lm(HolFitI,data.frame(ResDensity=Lengths))
      datashort[j,"HollingI_AIC"]<-AIC(HolFitI)
      lines(Lengths,Predict_HolI,col=cbbPalette[3],lwd=2.5) 
      datashort[j,"aI"]<-HolFitI$coefficients[2]  
      datashort[j,"aIp"]<-summary(HolFitI)[[4]][[2,4]]
    }
    if("try-error" %in% class(HolFitII)){        
      datashort[j,"FailHolII"]<-1
    } else {
      Predict_HolII<- HollingII(Lengths,a=coef(HolFitII)["a"], h=coef(HolFitII)["h"])
      lines(Lengths,Predict_HolII,col=cbbPalette[2],lwd=2.5) 
      datashort[j,"HollingII_AIC"]<-AIC(HolFitII)
      datashort[j,"aII"]<-summary(HolFitII)$parameters[1]
      datashort[j,"hII"]<-summary(HolFitII)$parameters[2]
      datashort[j,"aIIp"]<-summary(HolFitII)[[10]][[1,4]]
      datashort[j,"hIIp"]<-summary(HolFitII)[[10]][[2,4]]
    }
    ##generalised holling
    if("try-error" %in% class(HolFitIII)){        
      datashort[j,"FailHolIII"]<-1
    } else {
      Predict_HolIII<- HollingIII(Lengths, a=coef(HolFitIII)["a"], h=coef(HolFitIII)["h"] , q=coef(HolFitIII)["q"])
      lines(Lengths,Predict_HolIII,col=cbbPalette[5],lwd=2.5)
      datashort[j,"HollingIII_AIC"]<-AIC(HolFitIII)
      datashort[j,"aIII"]<-summary(HolFitIII)$parameters[1]
      datashort[j,"hIII"]<-summary(HolFitIII)$parameters[2]
      datashort[j,"qIII"]<-summary(HolFitIII)$parameters[3]
      datashort[j,"qse"]<-summary(HolFitIII)$parameters[3,2]
      datashort[j,"aIIIp"]<-summary(HolFitIII)[[10]][[1,4]]
      datashort[j,"hIIIp"]<-summary(HolFitIII)[[10]][[2,4]]
      datashort[j,"qIIIp"]<-summary(HolFitIII)[[10]][[3,4]]
    }
    
    graphics.off()
  }
  
  #  firstAIC<- match("HollingI_AIC",names(datashort))
  # lastAIC<-match("Poly3_AIC",names(datashort))
  #datashort[j,"BestAIC"]<- which(datashort[j,firstAIC:lastAIC]==min(as.numeric(datashort[j,firstAIC:lastAIC]),na.rm = TRUE))

#2 holling ,3 gen holling ,4 pol(polnomial degree2), 5,polc (polynomal degree3)
write.csv(datashort,"../Results/CRatmodelfitting.csv")


#no adj R for nlls
#rss?