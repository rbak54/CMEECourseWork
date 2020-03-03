library(ggplot2)
library(ggthemes)

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

if (dir.exists("../Results/Plots")==FALSE){
  dir.create("../Results/Plots")
}

data<-read.csv("../Results/dataanalysiscrat.csv")
data1<-subset(data, aIp<0.05)
data2<-subset(data,hIIp<0.05 & aIIp<0.05)
data3a<-subset(data,aIIIp<0.05 )
data3h<-subset(data,hIIIp<0.05)
plot2con<-ggplot()+geom_point(aes(ConTemp,log(aII),color="Search Rate"),data=data2,size=4)+
  geom_point(aes(ConTemp,log(hII),color="Handling Time"),data=data2,size=4)+
  theme_bw()+scale_color_colorblind("Parameter")+xlab("Temperature (degrees C)")+ylab("log Parameter")+theme(text = element_text(size=20))

plot2res<-ggplot()+geom_point(aes(ResTemp,log(aII),color="Search Rate"),data=data2,size=4)+
  geom_point(aes(ResTemp,log(hII),color="Handling Time"),data=data2,size=4)+
  theme_bw()+scale_color_colorblind("Parameter")+xlab("Temperature (degrees C)")+ylab("log Parameter")+theme(text = element_text(size=20))

plot1con<-  ggplot()+geom_point(aes(ConTemp,log(aI),col="Search Rate"),data=data1,size=4)+
  theme_bw()+scale_color_colorblind("Parameter")+xlab("Temperature (degrees C)")+ylab("log Parameter")+theme(text = element_text(size=20))

plot1res<-ggplot()+
  geom_point(aes(ResTemp,log(aI),col="Search Rate"),data=data1,size=4)+
  theme_bw()+scale_color_colorblind("Parameter")+xlab("Temperature (degrees C)")+ylab("log Parameter")+theme(text = element_text(size=20))

#not so good for aIII-a worse model

plot3con<-ggplot()+
  geom_point(aes(ConTemp,log(aIII),col="Search Rate"),data=data3a,size=4)+ 
  geom_point(aes(ConTemp,log(hIII),col="Handling Time"),data=data3h,size=4)+
  theme_bw()+scale_color_colorblind("Parameter")+xlab("Temperature (degrees C)")+ylab("log Parameter")+theme(text = element_text(size=20))


 plot3res<- ggplot() + geom_point(aes(ResTemp, log(aIII), col = "Search Rate"),size =4,data = data3a) +
  geom_point(aes(ResTemp, log(hIII), col = "Handling Time"),size = 4,
             data = data3h) +
  theme_bw() + scale_color_colorblind("Parameter") + xlab("Temperature (degrees C)") +
  ylab("log Parameter") + theme(text = element_text(size = 20))


 
 ###changing these
 
 plot2conA<-ggplot()+geom_point(aes(ConTemp,log(aII)),color=cbbPalette[2],data=data2,size=4)+
   theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("log Search Rate")+theme(text = element_text(size=20))

 plot2conH<-ggplot()+geom_point(aes(ConTemp,log(hII)),color=cbbPalette[3],data=data2,size=4)+
   theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("Handling Time")+theme(text = element_text(size=20))
 
 
plot1conA<-ggplot()+geom_point(aes(ConTemp,log(aI)),color=cbbPalette[4],data=data1,size=4)+
     theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("log Search Rate")+theme(text = element_text(size=20))
   
   plot3conH<- ggplot()+geom_point(aes(ConTemp,log(hIII)),color=cbbPalette[5],data=data3h,size=4)+
     theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("Handling Time")+theme(text = element_text(size=20))
   
   plot3conA<-ggplot()+geom_point(aes(ConTemp,log(aIII)),color=cbbPalette[6],data=data3a,size=4)+
     theme_bw()+xlab("Consumer Temperature (degrees C)")+ylab("log Search Rate")+theme(text = element_text(size=20))
   
   
   
   

 #not so good for aIII-a worse model
 
 plot3con<-ggplot()+
   geom_point(aes(ConTemp,log(aIII),col="Search Rate"),data=data3a,size=4)+ 
   geom_point(aes(ConTemp,log(hIII),col="Handling Time"),data=data3h,size=4)+
   theme_bw()+scale_color_colorblind("Parameter")+xlab("Temperature (degrees C)")+ylab("log Parameter")+theme(text = element_text(size=20))
 
 
 plot3res<- ggplot() + geom_point(aes(ResTemp, log(aIII), col = "Search Rate"),size =4,data = data3a) +
   geom_point(aes(ResTemp, log(hIII), col = "Handling Time"),size = 4,
              data = data3h) +
   theme_bw() + scale_color_colorblind("Parameter") + xlab("Temperature (degrees C)") +
   ylab("log Parameter") + theme(text = element_text(size = 20))
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
printgraph<-function(name){
  png(paste0("../Results/Plots/",substitute(name),".png"))
  print(name)
  dev.off()
}


#printgraph(plot1con)
#printgraph(plot2con)
#printgraph(plot3con)
#printgraph(plot1res)
#printgraph(plot2res)
#printgraph(plot3res)
printgraph(plot1conA)
printgraph(plot2conA)
printgraph(plot2conH)
printgraph(plot3conA)
printgraph(plot3conH)
par(mfrow=c(3,1))
a<-lm(log(data1$aI)~data1$ConTemp)


##what des this meannnnnnnnn. 
plot(data1$ConTemp,log(data1$aI))
plot(data1$ConTemp,sqrt(a$residuals^2))
plot(data1$ConTemp,a$residuals)
#TRASH , ALL TRASH



#this graph shows that mechanistic is slightly better
modelbesttype<-  ggplot(data=data,aes(x=best.model.type,fill=BestAIC))+geom_bar(stat="count")+
  theme_bw()+theme(text = element_text(size = 15))+xlab("Best Model Type")+ylab("Number of models")+scale_fill_colorblind("Best Model")


  
#diff between holling and holling recal
modelbestholl<-ggplot(data=data, aes(BestAICHol))+xlab("Best Holling Model")+ylab("Number of models")+theme_bw()+geom_bar()+scale_fill_colorblind()+theme(text = element_text(size = 20))
modelbesthollrecal<-ggplot(data=data, aes(BestAICHolRECAL))+xlab("Best Holling Model")+ylab("Number of models")+theme_bw()+geom_bar()+theme(text = element_text(size = 20))
#type 2 most common then 1 then 3
modelbest<-ggplot(data=data, aes(BestAIC))+geom_bar()+ylim(0,75)+theme_bw()+theme(text = element_text(size = 15))+xlab("Best Model")+ylab("Number of models")
modelsecondbest<-ggplot(data=data, aes(BestAIC_sec))+geom_bar()+theme_bw()+theme(text = element_text(size = 15))+xlab("Best Model")+ylab("Number of models")

printgraph(modelbesttype)
printgraph(modelbestholl)
printgraph(modelbesthollrecal)
printgraph(modelbest)
printgraph(modelsecondbest)



  #working on temp mdel graph
ggplot(data=data,aes(x=best.model.type,fill=BestAIC))+geom_bar(stat="count")+
  theme_bw()+theme(text = element_text(size = 20))+xlab("Best Model Type")+ylab("Number of models")+scale_fill_colorblind("Best Model")
