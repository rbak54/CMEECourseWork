#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: demography.R 
#Desc: calculate Fst from genotype 
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019

#load data
turtlegenotypes<- read.csv("../Data/turtle.genotypes.csv", stringsAsFactors = FALSE,header=FALSE)
data2<- read.csv("../Data/turtle.csv", stringsAsFactors = FALSE,header=FALSE)


colcount<-matrix(nrow=4, ncol=2000)
#A<-matrix(1:40, nrow=4, ncol=10,byrow=TRUE
)#for (i in 1:nrow(A)){ # for ( i in A){
#  t<-turtlegenotypes,]
 # for (j in 1:ncol(turtlegenotypes)) { 
  # colcount[p,j]<- sum(turtlegenotypes, A[i,j] )
  #subset(turtlegenotypes,turtlegenotypes)
  
   #}
#}
##
#  subset()
for (i in 1:4){
  start<-(i-1)*10+1
  end<-start+9
  print(start)
  sub<-turtlegenotypes[start:end,]
  colcount[i,]<-colSums(sub)
 # sub
  #print(start)
}
colfreq<-colcount/4000
#now need to create PAIRWISE THING
x<-4
n<-x^2
Q=matrix(ncol=2, nrow=n)
R=matrix(ncol=2,nrow=0)
Q[,1]<-rep(1:x, each=x)
Q[,2]<-rep(1:x, x)
for ( p in 1:nrow(Q)){
  if (Q[p,1]>Q[p,2])
    R<-rbind(R,Q[p,])
}
##not right
Hs<-matrix(nrow=6, ncol=2000)
Ht<-matrix(nrow=6, ncol=2000)
Fst<-matrix(nrow=6, ncol=2000)
#for (1:ncol(colcount)){ 
for (go in (1:nrow(R))) {
  A1<-R[go,1]
  A2<-R[go,2]
  print(go)
  for (t in 1:2000) {
    FA1<-colfreq[A1,t]
    FA2<-colfreq[A2,t]
    Hs[go,t]<-FA1*(1-FA1)+FA2*(1-FA2)
    Ht[go,t]<-FA1*(1-FA1)+FA2*(1-FA2)+ ((FA1-FA2)^2)/2
    Fst[go,t]<-(Ht[go,t]- Hs[go,t])/Ht[go,t]
    }
}
P<-matrix(ncol=3,nrow=6)
P[,1:2]<-R
a<-rowMeans(Fst,na.rm = TRUE)
P[,3]<-a[]
FstMean<-mean(P[,3])
#Fst Mean is very close to 0 so there is unlikely to be subdivision
#for (a in nrow(P)){
#P[,3]<-rowMe ans()
 #go throughM each combbinaion and find hs ht and ft 

#MAT<-matrix(nrow=4,ncol=4)   
#colnames(MAT)<-c(1:4)
#for (j in 1:nrow(MAT)) {
 # for (i in 1:ncol(MAT)) {
  #  if ((i > j)==TRUE) {
   #   MAT[i,j]<-c(i,j)
  #  }
  #}
#}

#ARR<-array("NA",dim=c(4,4,2))
#for (j in 1:nrow(MAT)) {
#  for (i in 1:ncol(MAT)) {
#    if ((i > j)==TRUE) {
#      ARR[i,j,]<-c(i,j)
#    }
#  }
#}
#f<-matrix(nrow=16, ncol=2)
#print(ARM)
#ARM<-as.data.frame(ARR)
#ART<-t(ARR)
#f#or (i in 1:nrow(ARM)){ 
#    f[i,1]<-ARR[i,i,1]
 #   f[i,2]<-ARM[i,i,2]
  #  f[i+4,1]<-ARM[i,i]
   # f[i+4,2]<-ARM[i,i+4]
    #f[i+8,1]<-ARM[i,i] 
    #f[i+8,2]<-ARM[i,i+4]
    #f[i+12,1]<-ARM[i,i]
    #f[i+12,2]<-ARM[i,i+4]
    
#} 
#this stupid 
#next step- find H for each combo theb fst then averAGE
  #View(ARM)
#ARM<-na.omit(ARR) 
#for (a in ARR) {
#  i
  
#}