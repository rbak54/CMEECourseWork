#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: analysistidied.R
#Desc: analysing model results
#Arguments: none
#Input: none 
#Output: none
#Date: Feb 2020


library(xtable)
options(xtable.floating = FALSE)
#options(xtable.timestamp = "")  
library(ggplot2)
data<-read.csv("../Results/CRatmodelfitting.csv")

if (dir.exists("../Results/Tables")==FALSE){
  dir.create("../Results/Tables")
}
#add to python some of these 
data$BestAIC<-NA
data$BestAICHolRECAL<-NA
data$BestAICHol<-NA
data$qcil<-NA
data$qciu<-NA
data$qIIIci<-NA
data$qcil<-data$qIII-2*data$qse
data$qciu<-data$qIII+2*data$qse
data$best.model.type<-NA
data$Con_ForagingMovement<-tolower(data$Con_ForagingMovement)
#best AIC
ltHol<-as.vector(match("HollingI_AIC",names(data)):match("HollingIII_AIC",names(data)))
ltHolR<-as.vector(match("HollingI_AIC",names(data)):match("HollingII_AIC",names(data)))
lt2<-as.vector(match("HollingI_AIC",names(data)):match("Poly3_AIC",names(data)))
lt<-c(match("HollingI_AIC",names(data)):match("HollingII_AIC",names(data)),match("Poly2_AIC",names(data)):match("Poly3_AIC",names(data)))

for ( i in 1:nrow(data)){
  data$BestAIC[i]<-colnames(sort(data[i,lt2],decreasing = F)[1])
  #best of hollings
  data$BestAICHol[i]<-colnames(sort(data[i,ltHol],decreasing = F)[1])
  #second best model
  data$BestAIC_sec[i]<-colnames(sort(data[i,lt2],decreasing = F)[2])
  #here when recalculate if ci overlap 0 for gen holII--> recalculate best model and best holling model
  data$BestAICRECAL[i]<-ifelse(!is.na(data$qIII[i]) & (with(data, qcil[i] < 0 & qciu[i]> 0)),colnames(sort(data[i,lt],decreasing = F)[1]),colnames(sort(data[i,lt2],decreasing = F)[1]))
  data$BestAICHolRECAL[i]<-ifelse(!is.na(data$qIII[i]) & (with(data, qcil[i] < 0 & qciu[i]> 0)),colnames(sort(data[i,ltHolR],decreasing = F)[1]),colnames(sort(data[i,ltHol],decreasing = F)[1]) )
  data$qIIIci[i]<-ifelse(!is.na(data$qIII[i]) & (with(data, qcil[i] < 0 & qciu[i]> 0)),0,data$qIII[i])
}

#is the best model mechanistic or phenomomenological
data$best.model.type <- ifelse(data$BestAIC == "HollingI_AIC" | data$BestAIC== "HollingII_AIC" | data$BestAIC=="HollingIII_AIC", 'Mechanistic',
                               ifelse(data$BestAIC == "Poly2_AIC" | data$BestAIC == "Poly3_AIC", 'Phenomenological', 'No_successful_model'))
data$best.model.type.recal <- ifelse(data$BestAICRECAL == "HollingI_AIC" | data$BestAICRECAL== "HollingII_AIC" | data$BestAICRECAL=="HollingIII_AIC", 'Mechanistic',
                                     ifelse(data$BestAICRECAL == "Poly2_AIC" | data$BestAICRECAL == "Poly3_AIC", 'Phenomenological', 'No_successful_model'))

#plots

#this graph shows that mechanistic is slightly better
ggplot(data=data,aes(x=best.model.type,fill=BestAIC))+geom_bar(stat="count")
#but this changes if recal
ggplot(data=data,aes(x=best.model.type.recal,fill=BestAICRECAL))+geom_bar(stat="count")
# for formatting http://www.sthda.com/english/wiki/ggplot2-barplots-quick-start-guide-r-software-and-data-visualization 
#hist(data$qIIIci,breaks = 30)
#diff between holling and holling recal
ggplot(data=data, aes(BestAICHol))+geom_bar()+ylim(0,200)
ggplot(data=data, aes(BestAICHolRECAL))+geom_bar()+ylim(c(0,200))
#type 2 most common then 1 then 3
ggplot(data=data, aes(BestAIC))+geom_bar()+ylim(0,200)

ggplot(data=data,aes(x=BestAIC,fill=as.factor(Res_ForagingMovement)))+geom_bar(stat="count")
ggplot(data=data,aes(x=BestAIC,fill=as.factor(Con_ForagingMovement)))+geom_bar(stat="count")

#see messing for genus stuff
chitable<-matrix(nrow=2,ncol=2)
#chi squared goodness of fit
##stats to say different
Expected<-rep(0.2*nrow(data),5)
Observed<-unname(table(data$BestAIC))
chisquared<-sum(((Observed-Expected)^2)/Expected)
chitable[1,1]<-chisquared
chitable[1,2]<-1-pchisq(chisquared,4)
#so reject the null hypothesis that all models are as good as each other 
Expected<-rep(0.5*nrow(data),2)
Observed<-unname(table(data$best.model.type))
chisquared<-sum(((Observed-Expected)^2)/Expected)
chitable[2,1]<-chisquared
chitable[2,2]<-1-pchisq(chisquared,1)

colnames(chitable)<-c("Chi-squared","p-value")
rownames(chitable)<-c("Best Model","Best Model Type")

output_chitable<-xtable(chitable,label='chitable',caption = 'Results of chi-squared tests for whether the best model and the best model type (i.e phenomenological or mechanistic) are uniformally distributed')
print(output_chitable,floating=FALSE,tabular.environment = 'longtable',file ="../Results/Tables/output_chitable_latex.txt",caption.placement ="top")


#TPYE NOT SIGNIFICANT DIFFERENCE not significantly better
Expected<-rep((1/3)*sum(!is.na(data$BestAICHolRECAL)),3)
Observed<-unname(table(data$BestAICHolRECAL))
chisquared<-sum(((Observed-Expected)^2)/Expected)
1-pchisq(chisquared,2)
#There is not a flat distribution- for hol recal (i.e type 1 to III)

#https://stattrek.com/chi-square-test/goodness-of-fit.aspx

data$CUTCONTEMP<-NA
data$CUTCONTEMP<-cut(data$ConTemp,c(0,15,20,25,40))
variable<-"CUTCONTEMP" 

#data$CUTRESTEMP<-NA
#data$CUTRESTEMP<-cut(data$ResTemp,c(0,15,25,40))

#variable<-"CUTRESTEMP" 

table_observed<-table(data$BestAIC,data[,variable])+table(data$BestAIC_sec,data[,variable]) 
table_observed<-rbind(table_observed,colSums(table_observed))
table_observed<-cbind(table_observed,rowSums(table_observed))
Observed<-table(data$BestAIC,data[,variable])+table(data$BestAIC_sec,data[,variable]) 
Expected<-matrix(nrow=nrow(Observed),ncol=ncol(Observed))

for(i in 1:(nrow(table_observed)-1)){
  for (j in 1:(ncol(table_observed)-1)){
    Expected[i,j]<-(table_observed[nrow(table_observed),j]*table_observed[i,ncol(table_observed)])/table_observed[nrow(table_observed),ncol(table_observed)]
  }
}
Expected
df<-(nrow(Expected)-1)*(ncol(Expected)-1)
chisquared<-sum(((Observed-Expected)^2)/Expected)
chisquared
    1-pchisq(chisquared,df)
    #so nothin significant but pl

table_observed<-table(data$BestAICHolRECAL,data[,variable])
table_observed<-rbind(table_observed,colSums(table_observed))
table_observed<-cbind(table_observed,rowSums(table_observed))
Observed<-table(data$BestAICHolRECAL,data[,variable])
Expected<-matrix(nrow=nrow(Observed),ncol=ncol(Observed))
for(i in 1:(nrow(table_observed)-1)){
  for (j in 1:(ncol(table_observed)-1)){
    Expected[i,j]<-(table_observed[nrow(table_observed),j]*table_observed[i,ncol(table_observed)])/table_observed[nrow(table_observed),ncol(table_observed)]
  }
}
Expected
df<-(nrow(Expected)-1)*(ncol(Expected)-1)
chisquared<-sum(((Observed-Expected)^2)/Expected)
1-pchisq(chisquared,df)

#a and h stuff


data2<-subset(data,hIIp<0.05 & aIIp<0.05)
data1<-subset(data,aIp<0.05)
#because aIII so few are significant. 
#so can calc for ai,aii,hii,hiii
data3<-subset(data,hIIIp<0.05 & aIIIp<0.05)
data3h<-subset(data,hIIIp<0.05)











#summary(lm(data$ConTemp~log(data$aI)))     
#aI has 3 negative values which is why log is upset
#aII and aIII has NAs because model doesnt fit for all
#sum(is.na(log(data$aIII)))
#sum(is.na(data$aIII))
shapiro.test(na.omit(data$ResTemp))
dataset_aii<-subset(data2, !is.na(ResTemp) & !is.na(aII))
a<-lm(dataset_aii$ConTemp~log(dataset_aii$aII))
shapiro.test(a$residuals)
dataset_aiii<-subset(data3, !is.na(ResTemp) & !is.na(aIII))
a<-lm(dataset_aiii$ConTemp~log(dataset_aiii$aIII))
shapiro.test(a$residuals)
dataset_ai<-subset(data1, !is.na(ResTemp) & aI>0)
a<-lm(dataset_ai$ConTemp~log(dataset_ai$aI))
shapiro.test(a$residuals)

dataset_hiii<-subset(data3h, !is.na(hIII))
dataset_hii<-subset(data2, !is.na(hII))

#so not normally distributed . so lets do non parametric testing 
#so best to use spearman
cor.test(dataset_aii$ConTemp,dataset_aii$aII,method = "s")
#spearman not working because of ties in temperature
cor.test(dataset_aii$ConTemp,dataset_aii$aII,method = "k")
cor.test(dataset_aiii$ConTemp,dataset_aiii$aIII,method = "k")
cor.test(dataset_ai$ConTemp,dataset_ai$aI,method = "k")

cor.test(dataset_hii$ConTemp,dataset_hii$hII,method = "k")
cor.test(dataset_hiii$ConTemp,dataset_hiii$hIII,method = "k")


#now con
shapiro.test(na.omit(data$ConTemp))
dataset_aii<-subset(data2, !is.na(ConTemp)& !is.na(aII))
a<-lm(dataset_aii$ConTemp~log(dataset_aii$aII))
shapiro.test(a$residuals)
dataset_aiii<-subset(data3, !is.na(ConTemp) & !is.na(aIII))
a<-lm(dataset_aiii$ConTemp~log(dataset_aiii$aIII))
shapiro.test(a$residuals)
dataset_ai<-subset(data1,!is.na(ConTemp) &  aI>0)
a<-lm(dataset_ai$ConTemp~log(dataset_ai$aI))
shapiro.test(a$residuals)

dataset_hiii<-subset(data3h, !is.na(ConTemp) & !is.na(hIII))
dataset_hii<-subset(data2, !is.na(ConTemp) &!is.na(hII))

#so not normally distributed . so lets do non parametric testing 
#so best to use spearman

cor.test(dataset_aii$ConTemp,dataset_aii$aII,method = "s")
#spearman not working because of ties in temperature

n<-vector(length=4)

con_search_1<-cor.test(dataset_ai$ConTemp,dataset_ai$aI,method = "k")
n[1]<-nrow(dataset_ai)
con_search_2<-cor.test(dataset_aii$ConTemp,dataset_aii$aII,method = "k")
n[2]<-nrow(dataset_aii)
con_search_3<-cor.test(dataset_aiii$ConTemp,dataset_aiii$aIII,method = "k")
#not poss for aiii- only 20 where significant
con_hand_2<-cor.test(dataset_hii$ConTemp,dataset_hii$hII,method = "k")
n[3]<-nrow(dataset_hii)
con_hand_3<-cor.test(dataset_hiii$ConTemp,dataset_hiii$hIII,method = "k")
n[4]<-nrow(dataset_hiii)
testlist<-list(con_search_1,con_search_2,con_hand_2,con_hand_3)

output_temp_con<-matrix(nrow=length(testlist),ncol=4)

colnames(output_temp_con)<-c("z","tau","p-value","n")

rownames(output_temp_con)<-c("Search rate type I","Search rate type II", "Handling time type II", "Handling time type III")

for(i in 1:length(testlist)){
  output_temp_con[i,1]<-testlist[[i]]$statistic
  output_temp_con[i,2]<-testlist[[i]]$estimate
  output_temp_con[i,3]<-testlist[[i]]$p.value
  output_temp_con[i,4]<-n[i]
}
#this one a bit different because samplee size
output_temp_con_table<-xtable(output_temp_con,label='Paramtemp',caption = 'Table of results for Kendall rank order correlation tests for consumer temperature and parameter values.')
print(output_temp_con_table,floating=FALSE,tabular.environment = 'longtable',file ="../Results/Tables/output_temp_con_latex.txt",caption.placement ="top")

##section 2 of results 
sum(data$BestAIC=="HollingII_AIC")/length(data$BestAIC)
sum(data$BestAIC_sec=="Poly3_AIC")/length(data$BestAIC_sec)
sum(data$BestAIC_sec=="Poly2_AIC")/length(data$BestAIC_sec)
sum(data$best.model.type=="Mechanistic")/length(data$best.model.type)


##section3?
sum(data$BestAICHol=="HollingIII_AIC")-
sum(data$BestAICHolRECAL=="HollingIII_AIC")

#senction 1 of results
length(data$FailHolI)
sum(data$FailHolII>0,na.rm = T)
sum(data$FailHolIII>0,na.rm = T)
sum(data$FailPol2>0,na.rm = T)
sum(data$FailPol3>0,na.rm = T)
sum(data$hIIIp<0.05,na.rm=T)
#caption
write.csv(data,"../Results/dataanalysiscrat.csv")

