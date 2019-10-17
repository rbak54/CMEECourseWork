MyDF<-read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
head(MyDF)
plot(MyDF$Predator.mass,MyDF$Prey.mass)
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass),pch=20,xlab="Predator Mass (kg)",ylab="Prey Mass (kg)")
dev.off()
hist(MyDF$Predator.mass)
hist(log(MyDF$Predator.mass),xlab="Predator Mass (kg)",ylab="Count")
hist(log(MyDF$Predator.mass), col="lightblue", border="pink",xlab="Predator Mass (kg)", ylab="Count", font.lab=2, cex.lab=1.5,breaks=15, main= "Histogram of log predator mass")
hist(log(MyDF$Prey.mass), col="lightblue", border="pink",xlab="Prey Mass (kg)", ylab="Count", font.lab=2, cex.lab=1.5, breaks=15, main= "Histogram of log prey mass")

dev.off()
par(mfcol=c(2,1))
par(mfg=c(2,1))
hist(log(MyDF$Predator.mass),xlab="Predator Mass (kg)",ylab="Count", col="lightblue", border="pink",main="Predator")
par(mfg=c(2,1))
hist(log(MyDF$Prey.mass),xlab="Prey Mass (kg)",ylab="Count", col="lightgreen", border="pink", main="prey")

dev.off()
hist(log(MyDF$Predator.mass), # Predator histogram
     xlab="Body Mass (kg)", ylab="Count", 
     col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
     main = "Predator-prey size Overlap",breaks=15) 
hist(log(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T,breaks=15)
legend('topleft',c('Predators','Prey'),
       fill=c(rgb(1,0,0,0.5), rgb(0,0,1,0.5)))
#have made bin size same

dev.off()
boxplot(log(MyDF$Predator.mass), xlab="Location",ylab="Predator Mass",main="Predator mass")
boxplot(log(MyDF$Predator.mass)~MyDF$Location, xlab="Location",
        ylab="Predator Mass",main="Predator mass by location")
boxplot(log(MyDF$Prey.mass)~MyDF$Type.of.feeding.interaction,xlab="Location",ylab="Predator Mass",main="Predator mass by feeding interaction type")
##combining plot types

dev.off()
par(fig=c(0,0.8,0,0.8)) ###go over
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),
     xlab="Predator Mass (kg)", ylab= "Prey Mass (kg)")
par(fig=c(0,0.8,0.4,1),new=TRUE)
boxplot(log(MyDF$Predator.mass), horizontal=TRUE, axes=FALSE)
par(fig=c(0.55,1,0,0.8),new=TRUE)
boxplot(log(MyDF$Prey.mass),axes=FALSE)
mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE,line=-3)

####lattice plots
dev.off()
library(lattice)
densityplot(~log(Predator.mass)| Type.of.feeding.interaction, data=MyDF)
