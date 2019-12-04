#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: ho13.R
#Desc: anova
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
graphics.off()
rm(list=ls())

d<-read.table("../Data/SparrowSize.txt",header=TRUE)
d1<-subset(d, d$Wing!="NA")
hist(d1$Wing)
model1<-lm(Wing ~ Sex.1, data=d1)
summary(model1)
boxplot(d1$Wing~d1$Sex.1, ylab="Wing length (mm)")
anova(model1)
##residual mean squares-->within group mean squares
t.test(d1$Wing~d1$Sex.1, var.equal=TRUE)


##boxplod for a bunch of years. group is wing length of bird at different times.
boxplot(d1$Wing~d1$BirdID, ylab="WIng length (mm)")
require(dplyr)
tbl_df(d1)
glimpse(d1)
d$Mass  %>%  cor.test(d$Tarsus,  na.rm=TRUE) 	
d1  %>%   	
  group_by(BirdID)  %>% 	
  summarise  (count=length(BirdID))  
##below same as above.
count(d1,BirdID)
d1  %>%   	
  group_by(BirdID)  %>% 	
  summarise  (count=length(BirdID))    %>% 	
  count(count) 	

model3<-lm(Wing~as.factor(BirdID),  data=d1) 	
anova(model3)

boxplot(d$Mass~d$Year) 	
m2<-lm(d$Mass~as.factor(d$Year)) 	
anova(m2) 	
summary(m2)
t(model.matrix(m2)) 	
#subst excluding 2000
#make model
d2<-subset(d1,d1$Year!="2000")
md2<-lm(d2$Mass~as.factor(d2$Year)) 	
anova(md2) 	
summary(md2)
##without 2000, less significance. maybe 2000 was weird
