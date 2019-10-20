
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: MyBars.R 
#Desc: Make a bar chart from Results.txt
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
graphics.off()
require(ggplot2)
a<- read.table("../Data/Results.txt", header=TRUE)
head(a)
a$ymin<- rep(0,dim(a)[1]) #repeat, dimensions, append column of 0s
#make pdf
pdf("../Results/Results.pdf", 11.7, 8.3)
##make graph
p<-ggplot(a)
#first linerange
p<-p+geom_linerange(data=a, aes(x= x, 
                                ymin = ymin, 
                                ymax= y1, 
                                size=(0.5)
                                ),
                              colour="#E69F00",
                              alpha=1/2, show.legend=FALSE)
#second linerange
p<- p + geom_linerange(data= a, aes(
                        x= x,
                        ymin= ymin,
                        ymax=y2,
                        size=(0.5)
                        ),
                      colour="#56B4E9",
                      alpha=1/2, show.legend=FALSE)
p<- p + geom_linerange(data= a, aes(
                        x= x,
                       ymin= ymin,
                       ymax=y3,
                       size=(0.5)
                       ), 
                       colour="#D55E00",
                       alpha=1/2, show.legend=FALSE)
p<- p +scale_x_continuous("My x axis", 
                       breaks=seq(3,5, by = 0.05))
p<- p +scale_y_continuous("My y axis")
p<-p+theme_bw() + theme(legend.position = "none")
p
print(p)
graphics.off()