require(ggplot2)
MyDF<- read.csv("../Data/EcolArchives-E089-51-D1.csv")
qplot(Prey.mass, Predator.mass, data=MyDF)
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF)
dev.off()
qplot(log(Prey.mass),log(Predator.mass),data=MyDF, colour= Type.of.feeding.interaction)
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, shape= Type.of.feeding.interaction)
dev.off()
qplot(log(Prey.mass), log(Predator.mass),data=MyDF, colour=I("red"))
dev.off()
qplot(log(Prey.mass), log(Predator.mass),data=MyDF, colour=I("red"))
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, size=I(3))
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, size=3)
dev.off()
###I needed for shape because discree variable
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, shape=I(3))
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, colour=Type.of.feeding.interaction, alpha=I(.5))
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, geom=c("point","smooth"))
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, geom=c("point","smooth")) + geom_smooth(method="lm")
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, geom=c("point","smooth"), colour=Type.of.feeding.interaction) + geom_smooth(method="lm")
dev.off()
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, geom=c("point","smooth"), colour=Type.of.feeding.interaction) + geom_smooth(method="lm", fullrange=TRUE)
dev.off()
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data= MyDF)
dev.off()
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data= MyDF, geom="jitter")
dev.off()
plot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data= MyDF, geom="boxplot")
qplot(log(Prey.mass/Predator.mass), data= MyDF, geom= "histogram")
dev.off()
qplot(log(Prey.mass/Predator.mass), data= MyDF, geom= "histogram",
      fill=Type.of.feeding.interaction)
#transpacrency
qplot(log(Prey.mass/Predator.mass), data=MyDF, geom= "density", 
      fill=Type.of.feeding.interaction, alpha=I(0.5))
#colour- endges
qplot(log(Prey.mass/Predator.mass), data= MyDF, geom= "density",
      colour=Type.of.feeding.interaction)
#multifaceted rather than all on one graohs
qplot(log(Prey.mass/Predator.mass), facets= Type.of.feeding.interaction~., data=MyDF,geom="density")
dev.off()
#~. -- by row
#.~: --by column
qplot()
qplot(log(Prey.mass/Predator.mass), facets= .~ Type.of.feeding.interaction, data=MyDF,geom="density")
dev.off()
##below doesn't work but not our fault
##qplot(log(Prey.mass/Predator.mass), facets= .~ Type.of.feeding.interaction + Location, 
        #data=MyDF, geom="density")
#can set axes to log!!
qplot(Prey.mass, Predator.mass, data=MyDF, log="xy",
      main="Relation",
      xlab="log(Prey mass) (g)",
      ylab="log(Predator mass (g)")+theme_bw()

pdf("../Results/MyFirst-ggplot2-figure.pdf")
print(qplot(Prey.mass, Predator.mass, data=MyDF, log="xy",
            main="Relation between predator and prey mass",
            xlab="log prey mass (g)",
            ylab="log predator mass (g)") +theme_bw())
dev.off()

##geom
MyDF <- as.data.frame(read.csv("../Data/EcolArchives-E089-51-D1.csv"))
head(MyDF)
#bar(count)
qplot(Predator.lifestage, data=MyDF, geom="bar")
#boxplot- 
qplot(Predator.lifestage, log(Prey.mass), data=MyDF, geom = "boxplot")
#density
qplot(log(Predator.mass),data=MyDF, geom="density")
#histogram
qplot(log(Predator.mass), data=MyDF, geom="histogram")
#scatterplot
qplot(log(Predator.mass), log(Prey.mass), data=MyDF, geom="point")
##smooth
qplot(log(Predator.mass), log(Prey.mass), data=MyDF, geom="smooth")
qplot(log(Predator.mass), log(Prey.mass), data=MyDF, geom="smooth", method="lm")

##ACTUAL GGPLOT
dev.off()
p<-ggplot(MyDF,aes(x=log(Predator.mass),
                   y=log(Prey.mass),
                   colour=Type.of.feeding.interaction))
q<- p + geom_point(size=I(2), shape=I(10)) + theme_bw()
q+theme(legend.position="none")

##plotting a matrix
dev.off()
require(reshape2)
GenerateMatrix<- function(N){
  M<-matrix(runif(N*N), N, N)
  return(M)
}
M<-GenerateMatrix(10)
Melt<-melt(M)
p<-ggplot(Melt,aes(Var1,Var2, fill=value))+geom_tile()
p+geom_tile(colour="black")
p+theme(legend.position="none",
        panel.background=element_blank(),
        axis.ticks=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        axis.text.x=element_blank(),
        axis.title.x =element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank() )
p+scale_fill_continuous(low="yellow", high="darkgreen")
p+scale_fill_gradient2()
p+scale_fill_gradientn(colours=grey.colors(10))
p+scale_fill_gradientn(colours=rainbow(10))
p+scale_fill_gradientn(colours=c("red","white","blue"))

##build function
dev.off()
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
##below is in Girko.R
#plot eigenvalues
dev.off()
p<-ggplot(eigDF, aes(x=Real, y=Imaginary))
p<-p+geom_point(shape=I(3))+theme(legend.position="none")
#vertical and horizontal lines
p<- p+geom_hline(aes(yintercept=0))
p<-p+geom_vline(aes(xintercept=0))
#add ellipse 
p<-p+geom_polygon(data=ellDF, aes(x= Real, y= Imaginary, alpha=1/20, fill= "red"))
p

###anotating plots
a<- read.table("../Data/Results.txt", header=TRUE)
head(a)
###ggthemes
require(ggplot2)
MyDF<- read.csv("../Data/EcolArchives-E089-51-D1.csv")
library(ggthemes)
q<- ggplot(MyDF, aes(x= log(Predator.mass), y=log(Prey.mass),
                     colour=Type.of.feeding.interaction)) + geom_point(size=I(2), shape=I(10))+
          theme_bw()
q<- q+ geom_rangeframe()+
  theme_tufte()
q
