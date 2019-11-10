
# killer whales

## read data for each population
## since data is encoded as 0 and 1 it's better to store it as a matrix

len <- 50000

data_N <- as.matrix(read.csv("../Data/killer_whale_North.csv", stringsAsFactors=F, header=F, colClasses=rep("numeric", len)))
dim(data_N)

data_S <- as.matrix(read.csv("../Data/killer_whale_South.csv", stringsAsFactors=F, header=F, colClasses=rep("numeric", len)))
dim(data_S)

## 1) estimates of effective population size

### Tajima's estimator

n <- nrow(data_N) # nr of samples (chromosomes)
pi_N <- 0
for (i in 1:(n-1)) {
	for (j in (i+1):n) {
		pi_N <- pi_N + sum(abs(data_N[i,]-data_N[j,]))
	}
}
pi_N <- pi_N / ((n*(n-1))/2)

n <- nrow(data_S) # nr of samples (chromosomes)
pi_S <- 0
for (i in 1:(n-1)) {
        for (j in (i+1):n) {
                pi_S <- pi_S + sum(abs(data_S[i,]-data_S[j,]))
        }
}
pi_S <- pi_S / ((n*(n-1))/2)

## estimates of Ne from Tajima's estimator
Ne_N_pi <- pi_N / (4 * 1e-8 * len)
Ne_S_pi <- pi_S / (4 * 1e-8 * len)

### Watterson's estimator

### calculate nr of SNPs and then the estimator
freqs <- apply(X=data_N, MAR=2, FUN=sum)/nrow(data_N)
snps_N <- length(which(freqs>0 & freqs<1))

watt_N <- snps_N / sum(1/seq(1,n-1))

freqs <- apply(X=data_S, MAR=2, FUN=sum)/nrow(data_S)
snps_S <- length(which(freqs>0 & freqs<1))

watt_S <- snps_S / sum(1/seq(1,n-1))

### estimates of Ne from Wattersons' estimator
Ne_N_watt <- watt_N / (4 * 1e-8 * len)
Ne_S_watt <- watt_S / (4 * 1e-8 * len)

cat("\nThe North population has estimates of effective population size of", Ne_N_pi, "and", Ne_N_watt)
cat("\nThe South population has estimates of effective population size of", Ne_S_pi, "and", Ne_S_watt)


## 2) site frequency spectra

### North population
sfs_N <- rep(0, n-1)
### allele frequencies
derived_freqs <- apply(X=data_N, MAR=2, FUN=sum)
### the easiest (but slowest) thing to do would be to loop over all possible allele frequencies and count the occurrences
for (i in 1:length(sfs_N)) sfs_N[i] <- length(which(derived_freqs==i))

### South population
sfs_S <- rep(0, n-1)
### allele frequencies
derived_freqs <- apply(X=data_S, MAR=2, FUN=sum)
### the easiest (but slowest) thing to do would be to loop over all possible allele frequencies and count the occurrences
for (i in 1:length(sfs_S)) sfs_S[i] <- length(which(derived_freqs==i))

### plot
barplot(t(cbind(sfs_N, sfs_S)), beside=T, names.arg=seq(1,nrow(data_S)-1,1), legend=c("North", "South"))

cat("\nThe population with the greater population size has a higher proportion of singletons, as expected.")

### bonus: joint site frequency spectrum

sfs <- matrix(0, nrow=nrow(data_N)+1, ncol=nrow(data_S)+1)
for (i in 1:ncol(data_N)) {

	freq_N <- sum(data_N[,i])
	freq_S <- sum(data_S[,i])

	sfs[freq_N+1,freq_S+1] <- sfs[freq_N+1,freq_S+1] + 1

}
sfs[1,1] <- NA # ignore non-SNPs

image(t(sfs))










#MYPRACTICE
##practice
#omat<-matrix(c(0,0,0,0,1,1,0,1,1,1,0,1,1,0,1),nrow=5,byrow=TRUE)
#ocolsum<-colSums(omat)
#tab<-tabulate(ocolsum)
#tab<-tab/sum(tab)
#plot(tab)
#allele_frequency<-c(1:(nrow(omat)-1))
#data<-rbind(allele_frequency,tab)
#barplot(tab,names.arg = allele_frequency)

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







