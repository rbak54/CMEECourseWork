#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Girko.R
#Desc: girko's circular simulation graph
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
graphics.off()
require(ggplot2)
##build function
#dev.off()
#returns eclipse
build_ellipse<- function(hradius, vradius){
  npoints=250
  a<-seq(0, 2* pi, length=npoints+1)
  x<-hradius*cos(a)
  y<-vradius*sin(a)
  return(data.frame(x=x, y=y))
}  
N<-250 #assign matrix
M<-matrix(rnorm(N*N), N, N)  #build matrix
eigvals<-eigen(M)$values  #eivenalues
eigDF<-data.frame("Real"=Re(eigvals),"Imaginary"=Im(eigvals)) #build dataframe
my_radius<-sqrt(N)  #radius of circle is sqrtN
ellDF<-build_ellipse(my_radius, my_radius) #dataframe to plot eclipse
names(ellDF)<-c("Real","Imaginary") #rename columns

##plotting
#plot eigenvalues
pdf("../Results/Girko.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
p<-ggplot(eigDF, aes(x=Real, y=Imaginary))
p<-p+geom_point(shape=I(3))+theme(legend.position="none")
#vertical and horizontal lines
p<- p+geom_hline(aes(yintercept=0))
p<-p+geom_vline(aes(xintercept=0))
#add ellipse 
p<-p+geom_polygon(data=ellDF, aes(x= Real, y= Imaginary, alpha=1/20, fill= "red"))
##saving as pdf
print(p)
graphics.off(); #you can also use dev.off()