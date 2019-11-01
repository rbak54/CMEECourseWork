#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: ho4.R
#Desc: standard errors
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
###standard errors
#se=sprt(s^2 / n)
library(pwr)
require(pander)
require(broom)
rm(list=ls())
d<-read.table("../Data/SparrowSize.txt", header=TRUE)
##se tarsus
d1<-subset(d,d$Tarsus!="NA")
seTarsus<-sqrt(var(d1$Tarsus)/length(d1$Tarsus))
seTarsus
##se 2001 tarsus
d12001<-subset(d1,d1$Year==2001)
seTarsus2001<-sqrt(var(d12001$Tarsus)/length(d12001$Tarsus))
seTarsus2001
#function to print se and n for different
SEnona<-function(s,t){
  a1<-subset(t,t!="NA")
  N<-length(a1)
  print("N=") 
  print(N)
  se<<-sqrt(var(a1)/length(a1))
  print("se=")
  return(se)
 #print(se="se")
  
}

SEnona(d,d$Tarsus)
SEnona(d,d$Mass)
SEnona(d,d$Wing)
SEnona(d,d$Bill)
d2001<-subset(d,d$Year==2001)
SEnona(d2001,d2001$Tarsus)
SEnona(d2001,d2001$Mass)
SEnona(d2001,d2001$Wing)
SEnona(d2001,d2001$Bill)

#confidence intervals
CI<-function(s,t) {
  a1<-subset(t,t!="NA")
  N<-length(a1)
  #print("N=") 
  #print(N)
  se<<-sqrt(var(a1)/length(a1))
  CI<<-1.96*se
  print("CI95= plus or minus")
  return(CI) 
  }
CI(d,d$Tarsus)

##hypothesis testing
#t-tests- can we fail to reject the null hypothesis
#t- takes mean of sample from true mean ad calculates t statistic
#df=sample=1
#p<0.05-- it's a convention! 
t.test(d2001$Tarsus,mu=18.5,na.rm=TRUE)
#alt- different, h0-not different 
#one sample t-test. compare sample to pop mean
t.test(d2001$Tarsus~d2001$Sex,na.rm=TRUE)
#t-statistic calculated by hings dependent on n
#probability distibutions
#theres different probability distributions
#z-scores. stidents t, chi square, ...
#EXAM COMMON Q- how would you write the methods / results of this is common in exam
#male and female tarsi did not differ in size between m and f (mean:twi sample t-test:t-,df=,p<)
#or can put in table
t.test1<-t.test(d$Mass~d$Sex.1)
t.test1
#alternative hypothesis true difference is not - and p very small
#looking at 95% cis, 9% of differences ebtween 0.77g and .37g
#could be type I error. large datasets more liely t pick up on small effect sizes
ds<-as.data.frame(head(d,50))
length(ds$Mass)
t.test2<-t.test(ds$Mass~ds$Sex)
t.test2

u<-mean(d$Wing)
dnonaW<-subset(d,d$Wing!="NA")

t.test3<-t.test(d2001$Wing,mu=mean(dnonaW$Wing),na.rm=TRUE)
t.test3
t.test4<-t.test(d2001$Wing~d2001$Sex)
t.test4
t.test5<-t.test(dnonaW$Wing~dnonaW$Sex)
t.test5
#class(t.test3)
#out <- capture.output(t.test3)
#cat("T-test3", out, file="t-tests.csv", sep="n", append=TRUE)
#out <- capture.output(t.test4)
#cat("T-test4", out, file="t-tests.csv", sep="n", append=TRUE)
#out <- capture.output(t.test5)
#cat("T-test5" out, file="t-tests.csv", sep="n", append=TRUE)
#sink("t-tests.txt")
#summary(t.test3)
#sink()
#https://stackoverflow.com/questions/32034815/format-ttest-output-by-r-for-tex

pander(t.test3)
#exploring ideas for nice output t test . eg stargazer, eg pander

#https://cran.r-project.org/web/packages/broom/vignettes/broom.html
glance(t.test3)
tidy(t.test3)

##above exploring how to output nicely . not mentioned in class. I like pander but still trying to get off R 

#errors##type 1 error- doctor telling pregnant person not preganant bc test wrong
##type 2 error- doctor telling person without uterus pregnant bc test said so
#always 5% type I error
#type 2 error -sample size  bigger, type 2 smallr


#> capture.output(pander(t.test3),file = "../Sandbox/pander.txt")THIS WAY WORKED
#> str(t.test3)


##don't want to focus so much on p-values. effect size is more helpful! so differences between values
#in the bird tarsus, 0.5mm was the effect size 
#think bout measurement error
#statistical power - mean, N(what we want to find out) ,sd, powe level(usually 80% is ok)
#pwr.t.test
#install.packages("pwr")

pwr.t.test(d=(0-0.16)/0.96,power=.8, sig.level=0.05,type="two.sample",alternative = "two.sided")
#not sure what d is foing
#n minus number of parameters to be estimated=df=n-2

#welth t-test - automatic ally replace students t test with welchs t test is assumptions not met (= variances, normal distribution)
#df looks weird, correcting for those things
