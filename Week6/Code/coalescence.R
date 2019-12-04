#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script:coalescence.R 
#Desc: effective population size and site frequency in killer wales
#Arguments: none
#Input: none 
#Output: none
#Date: Oct 2019
rm(list=ls())
graphics.off()

north<-as.matrix(read.csv("../Data/killer_whale_North.csv",stringsAsFactors = FALSE,colClasses=rep("numeric"), header=FALSE))
south<-as.matrix(read.csv("../Data/killer_whale_South.csv",stringsAsFactors = FALSE,colClasses=rep("numeric"), header=FALSE))
##Tajimas estimator 
#calc tajimas estimator if theta of pi,
##for each population- 1 north , 1 south
###first differences, sum them#
#matrix for camparisons
points<-0
x<-nrow(north)
n<-x^2
Q=matrix(ncol=2, nrow=n)
R=matrix(ncol=2,nrow=0)
Q[,1]<-rep(1:x, each=x)
Q[,2]<-rep(1:x, x)
for ( p in 1:nrow(Q)){
  if (Q[p,1]>Q[p,2])
    R<-rbind(R,Q[p,])
}  

##for tajima's estimator , calculate pairwise differences/ put in dijn  and dijs vector for north and south respectively
dijN<-vector(length=nrow(R))
points<-0
for (z in 1:nrow(R)){
  i<-R[z,1]
  j<-R[z,2]
  sam<-rbind(north[i,],north[j,])
  for (w in 1:ncol(sam)){
    if (length(unique(sam[,w]))==2){
     points<-points+1 
      } 
    dijN[z]<-points

  }
    sam<-c()
    i<-0
    j<-0
    points<-0
    }

dijS<-vector(length=nrow(R))
for (z in 1:nrow(R)){
i<-R[z,1]
j<-R[z,2]
sam<-rbind(south[i,],south[j,])
for (w in 1:ncol(sam)){
  if (length(unique(sam[,w]))==2) points<-points+1
dijS[z]<-points

}
sam<-c()
i<-0
j<-0
points<-0
}

##for waterson-N- count number of snps across all
points<-0  
for (w in 1:ncol(north)){
    if (length(unique(north[,w]))==2) points<-points+1
}
SN<-points
points<-0
#waterson S-count number of snps across all amino acids
for (w in 1:ncol(south)){
  if (length(unique(south[,w]))==2) points<-points+1
}
  SS<-points
points<-0

##calculating thetas
thetaNT<-sum(dijN)/((x*(x-1))/2)
thetaST<-sum(dijS)/((x*(x-1))/2)
denom<-0
  for (q in 1:(x-1)){
   denom<-denom+(1/q)
  }
thetaNW<-SN/denom
thetaSW<-SS/denom
# then theta=4N mu so can calc N
len<-ncol(north)
NeNW<-thetaNW/(4*1e-8*len)
NeSW<-thetaSW/(4*1e-8*len)
NeNT<-thetaNT/(4*1e-8*len)
NeST<-thetaST/(4*1e-8*len)

##SFS

##sfs north
colsum2<-c()
Northmax<-apply(X=north, MARGIN=2, FUN=max)

for (g in 1:ncol(north)){
  if (Northmax[g]>0){
  sumthis<-as.vector(north[,g])
  colsum2<-cbind(colsum2,sum(sumthis))
  }
}

tab<-tabulate(colsum2)
tab<-tab/sum(tab)
allele_frequency<-c(1:13)
barplot(tab,names.arg = allele_frequency)
##sfs for south
colsum2<-c()
Southmax<-apply(X=south, MARGIN=2, FUN=max)

for (g in 1:ncol(south)){
  if (Southmax[g]>0){
    sumthis<-as.vector(south[,g])
    colsum2<-cbind(colsum2,sum(sumthis))
  }
}

tab<-tabulate(colsum2)
tab<-tab/sum(tab)
allele_frequency<-c(1:20)
barplot(tab,names.arg = allele_frequency)
