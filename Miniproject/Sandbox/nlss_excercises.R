#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: nlss_excercises.R
#Desc: nlss
#Arguments:none 
#Input: none
#Output: none
#Date: Oct 2019
rm(list = ls())
graphics.off()
library(repr)
library("ggplot2")
library("minpack.lm")
powMod<- function(x, a, b) {
  return(a * x^b)
}
MyData<-read.csv("../Data/GenomeSize.csv")
head(MyData)
Data2Fit<- subset(MyData, Suborder == "Anisoptera")
Data2Fit<-Data2Fit[!is.na(Data2Fit$TotalLength),]
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)

ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight))+
  geom_point(size = (3), color="red") + theme_bw()+
  labs(y="Body mass (mg)", x = "Wing length (mm)")
PowFit<- nlsLM(BodyWeight ~ powMod(TotalLength, a , b), data= Data2Fit, start= list(a = .1, b = .1))
summary(PowFit)
Lengths<- seq(min(Data2Fit$TotalLength), max(Data2Fit$TotalLength), len=200)
coef(PowFit)["a"]
coef(PowFit)["b"]
Predic2PlotPow<-powMod(Lengths,coef(PowFit)["a"], coef(PowFit)["b"])
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col="blue", lwd=2.5)
confint(PowFit)
#alt model
QuaFit<- lm(BodyWeight ~ poly(TotalLength,2), data= Data2Fit)
Predic2PlotQua<-predict.lm(QuaFit, data.frame(TotalLength=Lengths))
#comparing models
plot(Data2Fit$TotalLength,Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col="blue", lwd=2.5)
lines(Lengths, Predic2PlotQua, col="red", lwd=2.5)
#formal comparison
RSS_Pow<- sum(residuals(PowFit)^2)
TSS_Pow<-sum((Data2Fit$BodyWeight - mean(Data2Fit$BodyWeight))^2)
RSq_Pow<-1- (RSS_Pow/TSS_Pow)

RSS_Qua<- sum(residuals(QuaFit)^2)
TSS_Qua<-sum((Data2Fit$BodyWeight- mean(Data2Fit$BodyWeight))^2)
RSq_Qua<-1-(RSS_Qua/TSS_Qua)
RSq_Pow
RSq_Qua
n<- nrow(Data2Fit)
pPow<-length(coef(PowFit))
pQua<-length(coef(QuaFit))
AIC_Pow <- n + 2 + n * log((2 * pi) / n) +  n * log(RSS_Pow) + 2 * pPow
AIC_Qua <- n + 2 + n * log((2 * pi) / n) + n * log(RSS_Qua) + 2 * pQua
AIC_Pow - AIC_Qua
AIC(PowFit)-AIC(QuaFit)
BIC(PowFit)-BIC(QuaFit)

LinFit <- lm(BodyWeight ~ TotalLength, data = Data2Fit)
Predic2Lin <- predict.lm(LinFit, data.frame(TotalLength = Lengths))
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)
lines(Lengths, Predic2PlotQua, col = 'red', lwd = 2.5)
lines(Lengths, Predic2Lin, col = 'green', lwd = 2.5)
##albatross chick
alb<- read.csv("../Data/albatross_grow.csv")
alb<- subset(x=alb, !is.na(alb$wt))
plot(alb$age, alb$wt, xlab="age (days)", ylab="weight (g)", xlim=c(0,100))
logistic1<-function(t,r,K,N0){
  N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
}
vonbert.w<-function(t, Winf, c, K){
  Winf*(1-exp(-K*t)+ c*exp(-K*t))^3
}
scale<-400
alb.lin<-lm(wt/scale~age, data=alb)
alb.log<-nlsLM(wt/scale~logistic1(age,r,K,N0),start=list(K=1, r=0.1, N0=0.1), data=alb)
alb.vb<-nlsLM(wt/scale~vonbert.w(age, Winf, c ,K), start=list(Winf=0.75, c=0.01, K=0.01), data=alb)

ages<-seq(0,100,length=1000)
pred.lin<-predict(alb.lin,newdata=list(age=ages))*scale
pred.log<-predict(alb.log, newdata = list(age=ages))*scale
pred.vb<-predict(alb.vb, newdata = list(age=ages))*scale
plot(alb$age, alb$wt, xlab="age (days)", ylab="weight (g)", xlim=c(0,100))
lines(ages, pred.lin, col=2, lwd=2)
lines(ages, pred.log, col=3, lwd=2)
lines(ages, pred.vb, col=4, lwd=2)
legend("topleft", legend=c("linear", "logistic", "Von Bert"), lwd=2, lty=1, col=2:4)
graphics.off()
par(mfrow=c(3,1), bty="n")
plot(alb$age, resid(alb.lin),main="LM resids", xlim=c(0,100))
plot(alb$age, resid(alb.log),main="Logistic resids", xlim=c(0,100))
plot(alb$age, resid(alb.vb),main="VB resids", xlim=c(0,100))
n<-length(alb$wt)
list(lin=signif(sum(resid(alb.lin)^2)/(n-2*2), 3),
     log=signif(sum(resid(alb.log)^2)/(n-2*3), 3),
     vb=signif(sum(resid(alb.vb)^2)/(n-2*2), 3))
##aedes aegypti
aedes<-read.csv("../Data/aedes_fecund.csv")
plot(aedes$T, aedes$EFD, xlab="temperature (C)", ylab="Eggs/day")
quad1<-function(T, T0, Tm, c){
  c*(T-T0)*(T-Tm)*as.numeric(T<Tm)*as.numeric(T>T0)
}
briere<-function(T,T0,Tm,c){
  c*T*(T-T0)*(abs(Tm-T)^(1/2))*as.numeric(T<Tm)*as.numeric(T>T0)
}
scale<-20
aed.lin<-lm(EFD/scale~T, data=aedes)
aed.quad<-nlsLM(EFD/scale~quad1(T, T0, Tm, c), start=list(T0=10, Tm=40, c=0.01), data=aedes)
aed.quad<-nlsLM(EFD/scale~briere( T, T0, Tm, c), start=list(T0=10, Tm=40, c=0.1), data=aedes)
