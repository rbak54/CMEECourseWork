
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: TAutoCorr.R 
#Desc: finds correlation and p-value for autocorrelation. ggplot2 graphs.
#Arguments: none
#Input: load ats file
#Output: none
#Date: Oct 2019

load("/home/ruth/Documents/CMEECourseWork/Week3/Data/KeyWestAnnualMeanTemperature.RData")
#utils::View(ats)
ats2<-dplyr::lag(ats$Temp,n=1)
ats1<-ats[,2]
ats1<-ats1[2:100]
ats2<-ats2[2:100]
#ats1<-as.character(ats1)
#ats2<-as.character(ats2)
H<-data.frame(ats1,ats2)
corR<-cor(ats1,ats2)
print(corR)
V<-rep(NA,10000)
#sample 10,000 random combination
for (i in 1:10000){
ats2<-sample(ats2)
cor<-cor(ats1,ats2)
V[i]=cor
}
Bee=0
#count how many random values are greater than actual correlation
for (v in V) {
  if (v > corR){
  Bee=Bee+1}
}
#proportion greater
p<-(Bee/length(V))
print(p)
graphics.off()
A<-as.data.frame(V)
##ggplot with my value on # write some words in
#head(A)
require(ggplot2)
#ggplots
Q<-ggplot(ats,aes(Year,Temp))+geom_line()+ylab("Temperature")+ggtitle("Temperature changes from 1900 to 2000")
R<-ggplot(H,aes(ats1,ats2))+geom_point()+geom_smooth(method="lm")+xlab("Temperature in year n")+ylab("Temperature in year n+1")+ ggtitle("Temperature change between years")
S<-ggplot(A,aes(V))+geom_density()+xlab("Correlation Coefficient")+ylab("Density")+
  geom_vline(xintercept=corR,colour="blue", show.legend = TRUE)+
  geom_text(x=0.1,y=3, label="Weather Autocorrelation = 0.326", color="blue")+
  ggtitle("Correlation Coefficient density")
graphics.off()