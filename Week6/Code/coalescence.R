#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script:coalescence.R 
#Desc: effective population size and site frequency in killer wales
#Arguments: none
#Input: none 
#Output: none
#Date: Oct 2019
north<-read.csv("../Data/killer_whale_North.csv",stringsAsFactors = FALSE,colClasses = c("character"), header=FALSE)
south<-read.csv("../Data/killer_whale_South.csv",stringsAsFactors = FALSE,colClasses = c("character"), header=FALSE)
##Tajimas estimator 
#calc tajimas estimator if theta of pi,
##for each population- 1 north , 1 south
###first differences, sum them
points<-0
x<-10
n<-x^2
Q=matrix(ncol=2, nrow=n)
R=matrix(ncol=2,nrow=0)
Q[,1]<-rep(1:x, each=x)
Q[,2]<-rep(1:x, x)
for ( p in 1:nrow(Q)){
  if (Q[p,1]>Q[p,2])
    R<-rbind(R,Q[p,])
}  

#Q=matrix(ncol=2, nrow=400)
 # Q[,1]<-rep(1:20, each=20)
  #Q[,2]<-rep(1:20, 20)
  #R<-matrix(ncol=4, nrow=400)
  #R[,1]<-Q[,1]
  #R[,2]<-Q[,2]
  #R[,3]<-Q[,2]
  #R[,4]<-Q[,1]
#S<-c()
#for (i in 1:nro4w(Q)){
#  a<-Q[i,c(1,2)]
#  b<-Q[i,c(1,2)]
  #c<-b[,c(2,1)]
 # c<-replace(b, c(1, 2), b[c(2, 1)])
#  if (a[i,1]< a[i,2]){
#    S<-rbind(S,q[i,])
 # if (a!=c) {
  # S<-rbind(S,Q[i,]) 
# }
#}
  #Qm<-unique(Q, margin=2) 

##iissue is 0 for everything
#tajima for n
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
#length(unique(sam[m]))
   # z=3
 # i<-R[z,1]
  #j<-R[z,2]
  #sam<-rbind(north[i,],north[j,])
#for (i in 1:ncol(sam)){
 # if (length(unique(sam[,i]))==2) points<-points+1
  #dijN[z]<-points
#  sam<-c()
 # i<-0
  #j<-0
#  points<-0

#tajuima for S
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

##for waterson-N
points<-0  
for (w in 1:ncol(north)){
    if (length(unique(north[,w]))==2) points<-points+1
}
SN<-points
points<-0
#waterson S
for (w in 1:ncol(south)){
  if (length(unique(south[,w]))==2) points<-points+1
}
  SS<-points
points<-0

##calculating thetas
n<-x
thetaNT<-sum(dijN)/((n*(n-1))/2)
thetaST<-sum(dijS)/((n*(n-1))/2)
m<-10
v<- m-1
denom<-0
  for (q in 1:(m-1)){
   denom<-denom+(1/q)
  }
thetaNW<-SN/denom
thetaSW<-SS/denom
# then theta=4N mu so can calc N
len<-length(north)
NeNW<-thetaNW/(4*1e-8*len)
NeSW<-thetaSW/(4*1e-8*len)
NeNT<-thetaNT/(4*1e-8*len)
NeST<-thetaST/(4*1e-8*len)
