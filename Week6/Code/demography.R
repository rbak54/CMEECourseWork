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
#subset the data for each of 4 groups then calculate sums of genotype information
for (i in 1:4){
  start<-(i-1)*10+1
  end<-start+9
  print(start)
  sub<-turtlegenotypes[start:end,]
  colcount[i,]<-colSums(sub)

}
#convert to column frequency
colfreq<-colcount/4000
#pairwise comparison setup
x<-4
n<-x^2
Q=matrix(ncol=2, nrow=n)
R=matrix(ncol=2,nrow=0)
Q[,1]<-rep(1:x, each=x)
Q[,2]<-rep(1:x, x)
for ( p in 1:nrow(Q)){
  if (Q[p,1]<Q[p,2])
    R<-rbind(R,Q[p,])
}
#empty table for pairwise comparisons to occur in 
Hs<-matrix(nrow=6, ncol=2000)
Ht<-matrix(nrow=6, ncol=2000)
Fst<-matrix(nrow=6, ncol=2000)
#define A1 and A2 for each of the comparisons using pairwise comparison table (R)
for (go in (1:nrow(R))) {
  A1<-R[go,1]
  A2<-R[go,2]
  #across rows, define FA1 and FA2 to calculate Hs,Ht and Fst
  for (t in 1:2000) {
    FA1<-colfreq[A1,t]
    FA2<-colfreq[A2,t]
    Hs[go,t]<-FA1*(1-FA1)+FA2*(1-FA2)
    Ht[go,t]<-FA1*(1-FA1)+FA2*(1-FA2)+ ((FA1-FA2)^2)/2
    Fst[go,t]<-(Ht[go,t]- Hs[go,t])/Ht[go,t]
    }
}
#matrix containing means across all snps
P<-matrix(ncol=3,nrow=6)
P[,1:2]<-R
T<-rowMeans(Fst,na.rm = TRUE)
P[,3]<-T[]
#mean across all population comparisons
FstMean<-mean(P[,3])
#Fst Mean is very close to 0 so there is unlikely to be subdivision
#some differences between comparisons but all values very low
#compare distance and fst-plot
dist<-c(5,10,12,50)
T2<-c()
for (i in 1:nrow(R)) { 
 a<-R[i,1]
  b<-R[i,2]
  da<-dist[a]
  db<-dist[b]
  T2[i]<-db-da
}
U<-cbind(T,T2)

colnames(U)<-c("fst",
               "dist")
x<-U[,2]
y<-U[,1]
plot(x,y)
#genetic distance doesn't seem to correlate with distance