#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: plotting.R
#Desc: plots graphs
#Arguments: none
#Input: none 
#Output: none
#Date: march 2020


library(ggplot2)

#colour palette
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

if (dir.exists("../Results/Plots")==FALSE){
  dir.create("../Results/Plots")
}
#function to plot graphs
printgraph<-function(name){
  png(paste0("../Results/Plots/",substitute(name),".png"))
  print(name)
  dev.off()
}
#data
data<-read.csv("../Results/dataanalysiscrat.csv")

#subsetting
data1<-subset(data, aIp<0.05)
data2<-subset(data,hIIp<0.05 & aIIp<0.05)
data3a<-subset(data,aIIIp<0.05 )
data3h<-subset(data,hIIIp<0.05)
 
#temperature and parameter graphs
plot2conA<-ggplot()+geom_point(aes(ConTemp,log(aII)),color=cbbPalette[4],data=data2,size=4)+
   theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("log Search Rate")+theme(text = element_text(size=20))

plot2conH<-ggplot()+geom_point(aes(ConTemp,log(hII)),color=cbbPalette[2],data=data2,size=4)+
   theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("Handling Time")+theme(text = element_text(size=20))
 
plot1conA<-ggplot()+geom_point(aes(ConTemp,log(aI)),color=cbbPalette[4],data=data1,size=4)+
     theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("log Search Rate")+theme(text = element_text(size=20))
   
plot3conH<-ggplot()+geom_point(aes(ConTemp,log(hIII)),color=cbbPalette[2],data=data3h,size=4)+
     theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("Handling Time")+theme(text = element_text(size=20))
  
plot3conA<-ggplot()+geom_point(aes(ConTemp,log(aIII)),color=cbbPalette[4],data=data3a,size=4)+
     theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("log Search Rate")+theme(text = element_text(size=20))

#this graph shows that mechanistic is slightly better
modelbesttype <-
  ggplot(data = data, aes(x = best.model.type, fill = BestAIC)) + geom_bar(stat =
                                                                             "count") +
  theme_bw() + theme(text = element_text(size = 15)) + xlab("Best Model Type") +
  ylab("Number of models") + ylim(0, 125) + scale_fill_manual(values = c(cbbPalette[2:4], cbbPalette[7:8]), "Best Model")

#difference between holling and holling recal
modelbestholl <-
  ggplot(data = data, aes(BestAICHol)) + xlab("Best Holling Model") + ylab("Number of models") +
  ylim(0, 175) + theme_bw() + geom_bar() + theme(text = element_text(size = 20))
modelbesthollrecal <-
  ggplot(data = data, aes(BestAICHolRECAL)) + xlab("Best Holling Model") +
  ylab("Number of models") + ylim(0, 175) + theme_bw() + geom_bar() + theme(text = element_text(size = 20))
modelbest <-
  ggplot(data = data, aes(BestAIC)) + geom_bar() + ylim(0, 75) + theme_bw() +
  theme(text = element_text(size = 15)) + xlab("Best Model") + ylab("Number of models")
modelsecondbest <-
  ggplot(data = data, aes(BestAIC_sec)) + geom_bar() + theme_bw() + theme(text = element_text(size = 15)) +
  xlab("Second Best Model") + ylab("Number of models")
#temperature model graph
tempmodel <-
  ggplot(data = data, aes(CUTCONTEMPTYPE, fill = BestAIC)) + geom_bar(stat =
                                                                        "count", position = position_dodge()) + theme_bw() + theme(text = element_text(size = 20)) +
  xlab("Temperature Interval (degrees C)") + ylab("Number of models") + scale_fill_manual(values =
                                                                                            c(cbbPalette[2:4], cbbPalette[7:8]), "Best Model")
tempmodelrhol <-
  ggplot(data = data, aes(CUTCONTEMPHOLLING, fill = BestAICHolRECAL)) + geom_bar(stat =
                                                                                   "count", position = position_dodge()) + theme_bw() + theme(text = element_text(size = 20)) +
  xlab("Temperature Interval (degrees C)") + ylab("Number of models") + scale_fill_manual(values =
                                                                                            c(cbbPalette[2:4]), "Best Holling Model")
temppmodeltype <-
  ggplot(data = data, aes(CUTCONTEMPTYPE, fill = best.model.type)) + geom_bar(stat =
                                                                                "count", position = position_dodge()) + theme_bw() + theme(text = element_text(size = 20)) +
  xlab("Temperature Interval (degrees C)") + ylab("Number of models") + scale_fill_manual("Best Model Type", values =
                                                                                            c(cbbPalette[5:6]))

#save graphs
printgraph(modelbesttype)
printgraph(modelbestholl)
printgraph(modelbesthollrecal)
printgraph(modelbest)
printgraph(modelsecondbest)
printgraph(tempmodelrhol)
printgraph(temppmodeltype)
printgraph(tempmodel)
printgraph(plot1conA)
printgraph(plot2conA)
printgraph(plot2conH)
printgraph(plot3conA)
printgraph(plot3conH)

