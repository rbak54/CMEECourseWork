#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: ho18.R
#Desc: mixed effects models and repeatability
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
rm(list=ls())
graphics.off()

library(dplyr)
require(lme4)
a<-read.table("../Data/ObserverRepeatability.txt", header = TRUE)
a  %>%   	
  group_by(StudentID)  %>% 	
  summarise  (count=length(StudentID)) 	
a  %>%   	
  group_by(StudentID)  %>% 	
  summarise  (count=length(StudentID))    %>% 	
  summarise  (length(StudentID))#

a  %>%   	
  group_by(StudentID)  %>% 	
  summarise  (count=length(StudentID))  %>% 	
  summarise  (sum(count)) 	
length(a$StudentID)

a  %>%   	
  group_by(StudentID)  %>% 	
  summarise  (count=length(StudentID))  %>% 	
  summarise  (sum(count^2)) 	

mod<-lm(Tarsus~StudentID,data=a)
anova(mod)
mod<-lm(Tarsus~Leg+Handedness+StudentID,data=a) 	
anova(mod)
lmm<-lmer(Tarsus~Leg+Handedness+(1|StudentID),data=a)
#modelling studnet id as random effect
summary(lmm)
var(a$Tarsus)
##repeatability is amoung/amoung +within