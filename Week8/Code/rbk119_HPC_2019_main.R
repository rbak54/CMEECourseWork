# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Ruth Keane"
preferred_name <- "Ruth"
email <- "ruth.keane19@imperial.ac.uk"
username <- "rbk119"
personal_speciation_rate <- # will be assigned to each person individually in class and should be between 0.002 and 0.007

# Question 1
species_richness <- function(community){
  richness<-length(unique(community))
  return(richness)
}

# Question 2
init_community_max <- function(size){
   imax<-as.vector(seq(1,size,1))
  return(imax)
}

# Question 3
init_community_min <- function(size){
  imin<-rep(1,length=size)
  return(imin)
}

# Question 4
choose_two <- function(max_value){
  imax<-as.vector(seq(1,max_value,1))
  two<-as.vector(sample(imax,2,replace=FALSE))
  return(two)
}

# Question 5
neutral_step <- function(community){
  indexes<-choose_two(length(community))
 community2<-community[-indexes[1]]
 community2<-c((community[indexes[2]]),community2)
  return(community2)
}


# Question 6
neutral_generation <- function(community){
  a<-sample(1:2,1)
  generations<-length(community)/2 
  if(a==1){
    generations<-floor(generations)
  }else{
    generations<-ceiling(generations)
  }
  for (i in 1:generations){
      community<-neutral_step(community)
  }
 return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  richness<-vector(length=duration)
  for(j in (1:duration)){
    community<-neutral_generation(community)
    richness[j]<-species_richness(community)
  }
  return(richness)
}

# Question 8
question_8 <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(neutral_time_series(init_community_max(100),duration=200),xlab="Generation",ylab="Species Richness")
  return("Species richness of 1 ")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  indexes<-choose_two(length(community))
  community2<-community[-indexes[1]]
  rand<-runif(1,0,1)
  if(rand>speciation_rate){
    community2<-c((community[indexes[2]]),community2) 
  }else{
    community2<-c(community2,max(community)+1)
  }
  return(community2)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  a<-sample(1:2,1)
  generations<-length(community)/2 
  if(a==1){
    generations<-floor(generations)
  }else{
    generations<-ceiling(generations)
  }
  for (i in 1:generations){
    community<-neutral_step_speciation(community,speciation_rate =speciation_rate)
  }
  return(community)
}


# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  richness<-vector(length=duration)
  for(j in (1:duration)){
    community<-neutral_generation_speciation(community=community, speciation_rate = speciation_rate)
    richness[j]<-species_richness(community)
  }
  return(richness)
}

# Question 12
question_12 <- function()  {
  graphics.off()
  #plot(neutral_time_series(init_community_max(100),duration=200),xlab="Generation",ylab="Species Richness")
  mat<-as.data.frame(matrix(ncol=3, nrow=400))
  min<-neutral_time_series_speciation(community=init_community_min(100),speciation_rate = 0.1, duration=200)
  max<-neutral_time_series_speciation(community=init_community_max(100),speciation_rate = 0.1, duration=200)
  time<-seq(1,200,1)
#  mat[1:200,2]<-min
 # mat[201:400,2]<-max
#  mat[,1]<-time
 # mat[1:200,3]<-"min"
#  mat[201:400,3]<-"max"
#  colnames(mat)<-c("time","rich","which")
  graphics.off()
  plot(time,min,col="blue",ylab="Species richness")
  points(time,max,col="red")
  #matrix<-matrix(c(a,b),nrow=200)
#  require(ggplot2)
  #  ggplot(aes(mat[,1],mat[,2],colour=which), data=mat)+geom_point()+xlab("Generation")+ylab("Species Richness")
  return("They converge to similar species richnesses. The neutral model gives these results because new species are being added and the when there are many species, there is a higher chance of a population going extinct")
}


# Question 13
species_abundance <- function(community)  {
  
 # for (i in (1:range(max(community)))){
  t<-table(community)
  t<-sort(t,decreasing = TRUE)
 # t<-as.data.frame(t)
  f<-vector()
  j=0
  for (i in t){
    j=j+1
    f[j]<-i
  }
   return(f)
  }

# Question 14
octaves <- function(abundance_vector) {
  #to find n
  m<-max(abundance_vector)
  nm<-log(m)/log(2)
  nm<-ceiling(nm)
  t<-tabulate(abundance_vector)
  v<-vector(length=nm)
  for (n in (1:nm)){
    a<-2^(n-1)
    b<-(2^n)-1
    v[n]<-sum(t[a:b],na.rm = TRUE)
  }
  return(v)
  }
  
# Question 15
sum_vect <- function(x, y) {
  lx<-length(x)
  ly<-length(y)
  if (lx>ly){
    yn<-rep(0,lx)
    yn[1:ly]<-y
    y<-yn
    }else{
      xn<-rep(0,ly)
      xn[1:lx]<-x
      x<-xn
    }
  s<-x+y
  return(s)
}

# Question 16 
question_16 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  oc<-matrix(nrow=200,ncol=10)
  max<-init_community_max(100)
  for (p in 1:200){
  max<-neutral_generation_speciation(community=max,speciation_rate = 0.1)
  }
  ab<-species_abundance(max)
  oc<-octaves(ab)
  o<-1
  #oc[1,1:length(octaves(ab))]<-octaves(ab)
  
  #dont need to do both
  gens<-seq(20,2000,20)
  nint<-1:19
  
  for (d in gens){
    for (q in nint){
      max<-neutral_generation_speciation(community=max,speciation_rate = 0.1)}
    max<-neutral_generation_speciation(community=max,speciation_rate = 0.1)
    ab<-species_abundance(max)
    o<-o+1
    #oc[o,1:length(octaves(ab))]<-octaves(ab)
    oc<-sum_vect(oc,octaves(ab))
  }
  oc<-oc/o
  barplot(oc)
  #return(oc)
  return("type your written answer here")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
 community<-init_community_min(size=size)
 a<-proc.time()
 b<-proc.time()-a
 while (b[3]<wall_time){
   neutral_generation_speciation(community=community,speciation_rate =speciation_rate )
   b<-proc.time()-a
 
 }
  
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  # clear any existing graphs and plot your graph within the R window
  combined_results <- list() #create your list output here to return
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  return("type your written answer here")
}

# Question 22
question_22 <- function()  {
  return("type your written answer here")
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Question 24
turtle <- function(start_position, direction, length)  {

  return() # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  return("type your written answer here")
}

# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  
}

# Question 28
tree <- function(start_position, direction, length)  {
  
}
draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Question 29
fern <- function(start_position, direction, length)  {
  
}
draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Question 30
fern2 <- function(start_position, direction, length)  {
  
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


