#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: rbk119_HPC_2019_main.R
#Desc: main classwork HPC
#Arguments: none
#Input: none
#Output: none
#Date: Nov 2019

rm(list=ls())
graphics.off()

# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Ruth Keane"
preferred_name <- "Ruth"
email <- "ruth.keane19@imperial.ac.uk"
username <- "rbk119"
personal_speciation_rate <- 0.004345 
#only for hpc # will be assigned to each person individually in class and should be between 0.002 and 0.007
require(ggplot2)
# Question 1
species_richness <- function(community){
  #calculate number of unique species in the community
  richness<-length(unique(community))
  return(richness)
}

# Question 2
init_community_max <- function(size){
   #make a vector from one to the size of the community
  imax<-as.vector(seq(1,size,1))
  return(imax)
}

# Question 3
init_community_min <- function(size){
  #make a vector of ones the size of the community
  imin<-rep(1,length=size)
  return(imin)
}

# Question 4
choose_two <- function(max_value){
  #make a vector with values between 1 and max value
  imax<-as.vector(seq(1,max_value,1))
  #randomly sample two from this vector
  two<-as.vector(sample(imax,2,replace=FALSE))
  return(two)
}

# Question 5
neutral_step <- function(community){
  #get two random values from the length of community
  indexes<-choose_two(length(community))
  #remove one of these indexes in community
  community2<-community[-indexes[1]]
  #replace this with the second index of community
  community2<-c((community[indexes[2]]),community2)
  return(community2)
}


# Question 6
neutral_generation <- function(community){
  #sample 1 or 2
  a<-sample(1:2,1)
  #number of generations
  generations<-length(community)/2 
  #half the time round down generations
  if(a==1){
    generations<-floor(generations)
  }else{
  #half the time round up generations
    generations<-ceiling(generations)
  }
  for (i in 1:generations){
    #do neutral step generations number of time
    community<-neutral_step(community)
  }
 return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  #richness is an empty vector with length duration
  richness<-vector(length=duration)
  for(j in (1:duration)){
    #neutral generations for duration number of times
    community<-neutral_generation(community)
    #species richness at each timepoint
    richness[j]<-species_richness(community)
  }
  return(richness)
}

# Question 8
question_8 <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(neutral_time_series(init_community_max(100),duration=200),xlab="Generation",ylab="Species Richness")
  data<-as.data.frame(matrix(nrow=200,ncol=2))
  data[,2]<-neutral_time_series(init_community_max(100),duration=200)
  data[,1]<-1:200
  colnames(data)<-c("Generations","Richness")
  print(ggplot(aes(Generations,Richness),data=data)+theme_bw()
        +geom_point())
  return("Species richness of 1. This is because each generation a species can go extinct, but no speciation is happening")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  #choose two indexes for community
  indexes<-choose_two(length(community))
  #remove first index
  community2<-community[-indexes[1]]
  #random number between 0 and 1
  rand<-runif(1,0,1)
  if(rand>speciation_rate){
    #if random number is > speciation rate replace the deleted index with a second index
    community2<-c((community[indexes[2]]),community2) 
  }else{
    # if random number < speciation rate, add a new species by finding the maximum in community and adding 1
    community2<-c(community2,max(community)+1)
  }
  return(community2)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  a<-sample(1:2,1)
  #find number of generations 
  generations<-length(community)/2 
  if(a==1){
    generations<-floor(generations)
  }else{
    generations<-ceiling(generations)
  }
  for (i in 1:generations){
    #neutral steps generation times
    community<-neutral_step_speciation(community,speciation_rate =speciation_rate)
  }
  return(community)
}

  
# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  richness<-vector(length=duration)
  for(j in (1:duration)){
    #neutral generations with speciation for each in duration
    community<-neutral_generation_speciation(community=community, speciation_rate = speciation_rate)
    #find richess at this point and add to the vector
    richness[j]<-species_richness(community)
  }
  return(richness)
}

# Question 12
question_12 <- function()  {
  graphics.off()
  mat<-as.data.frame(matrix(ncol=3, nrow=400))
  mat[1:200,2]<-neutral_time_series_speciation(community=init_community_min(100),speciation_rate = 0.1, duration=200)
  mat[201:400,2]<-neutral_time_series_speciation(community=init_community_max(100),speciation_rate = 0.1, duration=200)
  mat[1:200,1]<-seq(1,200,1)
  mat[201:400,1]<-seq(1,200,1)
  mat[1:200,3]<-"Minimum"
  mat[201:400,3]<-"Maximum"
  colnames(mat)<-c("Generation","Species_Richness","Initial_Community_Size")
  print(ggplot(aes(Generation,Species_Richness,colour=Initial_Community_Size), data=mat)+ theme_bw()+geom_point())
  return("They converge to similar species richnesses. The neutral model gives these results because new species are being added and the when there are many species, there is a higher chance of individual species going extinct")
}


# Question 13
species_abundance <- function(community)  {
  ##use table to make contingency table of counts for each species in community
  community_table<-table(community)
  #sort table
  community_table<-sort(community_table,decreasing = TRUE)
  #abundancevec is the abundance of each species
  abundancevec<-unname(community_table)
   return(abundancevec)
  }

# Question 14
octaves <- function(abundance_vector) {
  ##to find number of octaves
  #finds largest abundance
  m<-max(abundance_vector)
  #finds octave number from maximum abundance
  number_of_octaves<-log(m)/log(2)
  #rounds up
  number_of_octaves<-ceiling(number_of_octaves)
  #contingency table for abundance values
  abundance_table<-tabulate(abundance_vector)
  #initialises vecotr for octaves with correct octave number
  octave_vector<-vector(length=number_of_octaves)
  #for each octave, find the minimum and maximum abundance for that octave , than find how many values in abundance_table fit into each octave
  for (n in (1:number_of_octaves)){
    a<-2^(n-1)
    b<-(2^n)-1
    octave_vector[n]<-sum(abundance_table[a:b],na.rm = TRUE)
  }
  return(octave_vector)
  }
  
# Question 15
sum_vect <- function(x, y) {
  len_x<-length(x)
  len_y<-length(y)
  if (len_x>len_y){
    #vector the length of x filled with 0s
    y_new<-rep(0,len_x)
    #add y values into this (remaining valyes in y_new stay as 0)
    y_new[1:len_y]<-y
    #replace y with ynew
    y<-y_new
    }else{
      #vector the length of y filled with 0s
      x_new<-rep(0,len_y)
      #add x values into this (remaining valyes in x_new stay as 0)
      x_new[1:len_x]<-x
      #replace x with x_new
      x<-x_new
    }
  #sum these vectors. 
  sum<-x+y
  return(sum)
}

# Question 16 
question_16 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  #initialise community with maximum or minimum possible species
  communityvec<-init_community_max(100)
  #communityvec<-init_community_min(100)
  
  #burn in period of 200 generations
  for (p in 1:200){
  communityvec<-neutral_generation_speciation(community=communityvec,speciation_rate = 0.1)
  }
  #octaves matrix is  octaves after burn in period
  octaves_matrix<-octaves(species_abundance(communityvec))
  #o is number of times the octave has been recorded
  o<-1
  #2000 generations, with octaves being recorded every 20 generations
  for (d in 1:100){
    for (q in 1:19){
      communityvec<-neutral_generation_speciation(community=communityvec,speciation_rate = 0.1)}
    communityvec<-neutral_generation_speciation(community=communityvec,speciation_rate = 0.1)
    abundance<-species_abundance(communityvec)
    #octave count increases and sum_vect used to add octave to octaves_matrix
    o<-o+1
    octaves_matrix<-sum_vect(octaves_matrix,octaves(abundance))
  }
  #divide octaves matrix by number of octaves added to find average
  octaves_matrix<-octaves_matrix/o
  #format data for ggplot
  plotting<-as.data.frame(matrix(nrow=length(octaves_matrix),ncol=2))
  plotting[,1]<-c(1:length(octaves_matrix))
  plotting[,2]<-octaves_matrix
  colnames(plotting)<-c("Octave","Average_Size_of_Octave")
  print(ggplot(aes(Octave,Average_Size_of_Octave),data=plotting)+geom_bar(stat="identity")+theme_bw()+scale_x_continuous(name="Octave Number",breaks=1:6,labels=1:6)+scale_y_continuous(name=" Average Size of Octave",breaks=1:10,labels=1:10))  #barplot(octaves_matrix)
  return("The initial community size is not important as the bar chart is the same shape for both init_community_min and init_community_max")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  #initialise community with minimum species richness
  community<-init_community_min(size=size)
  #to time
  a<-proc.time()
  b<-proc.time()-a
  nruns<-0
  richrows<-0
  richness<-c()
  oct<-list()
  #while time is less than wall time, run simulations. 
  while (((b[3])/60)<wall_time){
    community=neutral_generation_speciation(community=community,speciation_rate =speciation_rate )
    nruns=nruns+1
    b<-proc.time()-a
    #for burn in time measure richness every interval_rich generations
    if (nruns<burn_in_generations){
      if (nruns%%interval_rich==0){
        richness<-c(richness,species_richness(community))
      }
    }
    #find octave every interval_oct generations
    if (nruns%%interval_oct==1){
      octrows<-length(oct)+1
      oct[[octrows]]<-(octaves(species_abundance(community)))
      print(b)
    }
  }
  c<-proc.time()-a
  c<-c[3]
  filename<-paste0(output_file_name,".rda")
  # save inportant information as rda file
  save(oct,community,speciation_rate,richness,wall_time,interval_rich,interval_oct,burn_in_generations,size,c,file=filename)
}
# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  #make  2 lists containing 4 elements , one for each size
    octaves_list<-list(vect500=c(0),vect1000=c(0),vect2500=c(0),vect5000=c(0))
   count<-list(vect500=0,vect1000=0,vect2500=0,vect5000=0)
  #loop through each file
   for (i in 1:100){
    file<-paste0("output2_",i,".rda")
    load(file)
    #v- which vector will be added to- references list component
    v<-paste0("vect",size)
    #which is number of octaves in burn in period +1
    which<-(burn_in_generations/interval_oct)+1
    #for octaves after burn in period, add vector to the appropriate vector in list using sum_vect. and add 1 to count
    for (j in (which:length(oct))){
      octaves_list[[v]]<-sum_vect(octaves_list[[v]],oct[[j]])
      count[[v]]<-count[[v]]+1
    }
  }
  combined_results<-list(0,0,0,0)
  for (k in (1:length(octaves_list))){
    #find average octave vector for each size
        combined_results[[k]]<-octaves_list[[k]]/count[[k]]
  } 
  #plot barchart for each size
  par(mfrow=c(2,2))
     barplot(combined_results[[1]],main="Size=500",xlab="Species Abundance Octave",ylab="Mean frequency") 
     barplot(combined_results[[2]],main="Size=1000",xlab="Species Abundance Octave",ylab="Mean frequency")
     barplot(combined_results[[3]],main="Size=2500",xlab="Species Abundance Octave",ylab="Mean frequency")
     barplot(combined_results[[4]],main="Size=5000",xlab="Species Abundance Octave",ylab="Mean frequency")
     #save combined results in rda file
     save(combined_results,file="rbk119_cluster_results.rda")
  return(combined_results)
}

# Question 21
question_21 <- function()  {
 dimensions<-log(8)/log(3)
 ans<-list(dimensions,"when the width is multiplied by 3, the pattern repeats 8 times. 3^x=8. So x=log8/log3")
   return(ans)
}

# Question 22
question_22 <- function()  {
  dimensions<-log(20)/log(3)
  ans<-list(dimensions,"when the width is multiplied by three, the area is multiplied by 20. 3^x=20, so x=log20/log3")
  return(ans)
}

# Question 23
chaos_game <- function()  {
  graphics.off()
#initial points
  x<-c(0,0)
  A<-c(0,0)
  B<-c(3,4)
  C<-c(4,1)
  options<-list(A,B,C)
  #plot graph with initial x
  plot(x[1],x[2],cex=0.0001,xlim=c(0,5),ylim=c(0,5),xlab="",ylab="") #
  #sample one of A,B and C then move x halfway towards that point. add this to plot.
  for (i in 1:50000){
  s<-sample(options,1)
  s<-(s[[1]])
  x<-(x+s)/2
  points(x[1],x[2],cex=0.0001,col="dark green")
  }
  return("A fractal is made on the graph. increasing the repetitions makes this more well defined. However at higher numbers of points some definition is lost")
}

# Question 24
turtle <- function(start_position, direction, length,colour)  {
  #use SOHCAHTOA to find movement from initial point based on direction and length 
  adjacent<-cos(direction)*length
  opposite<-sin(direction)*length
  movement<-c(adjacent,opposite)
  #add change in point to find coordinated of new point
  end<-start_position+movement
  #plot line between new and old point
  segments(start_position[1],start_position[2],end[1],end[2],col=colour)
  return(end) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
 end<-turtle(start_position,direction,length,"blue") 
 turtle(start_position=end,direction=direction-pi/4,length=0.95*length,"blue")
}

# Question 26
spiral <- function(start_position, direction, length)  {
  start_position<-turtle(start_position,direction,length,"green") 
  if (length>0.01){
    #recurdive function. limited length stops it being an infinite loop
  start_position<-spiral(start_position=start_position,direction=direction-pi/4,length=length*0.95)
  }
  return("calling a function from a function in this way produces and infinite loop, causing an error message")
}
  
# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(-5:5,-5:5,"n")
  spi<-spiral(start_position = c(-2,1),direction<-pi/4,length=2)
  return(spi)
}

# Question 28
tree <- function(start_position, direction, length)  {
  start_position<-turtle(start_position,direction,length,"red") 
  if (length>0.01){
    tree(start_position=start_position,direction=direction-pi/4,length=length*0.65)
    tree(start_position=start_position,direction=direction+pi/4,length=length*0.65)
  }
}
draw_tree <- function()  {
   # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(c(-2,2),c(-1,3),xlab=" ", ylab=" ","n")
  tree(start_position = c(0,0), direction=pi/2, length=1)
}

# Question 29
fern <- function(start_position, direction, length)  {
  start_position<-turtle(start_position,direction,length,"red") 
  if (length>0.01){
    fern(start_position=start_position,direction=direction-pi/4,length=length*0.38)
    fern(start_position=start_position,direction=direction,length=length*0.87)
  }
}
draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(c(-2,2),c(-1,8),xlab=" ", ylab=" ","n")
  fern(start_position = c(0,0), direction=pi/2, length=1)
  }

# Question 30
fern2 <- function(start_position, direction, length,dir)  {
  start_position<-turtle(start_position,direction,length,"purple") 
  if (length>0.01){
    #direction changes each time
    fern2(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir=dir)
    fern2(start_position=start_position,direction=direction,length=length*0.87,dir=-dir)
    }
}
draw_fern2 <- function()  {
  graphics.off()
  plot(c(-2,2),c(0,8),xlab=" ", ylab=" ","n")
  fern2(start_position = c(0,0), direction=pi/2, length=1,dir=1)
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  
calc<-function(gen,community){
  # graphics.off()
  #initialise richness matrix gen columns and n rows where n is length of community
  n<-length(community)
  richness<-matrix(ncol=gen,nrow=n)
  #for each in comunity, calculate the richness change over gen generations
  for (i in 1:n){
    richness[i,]<-neutral_time_series_speciation(community=community,speciation_rate = 0.1,duration =gen)
  } 
  #make matrix containing 4 rows- mean, generation , lower bound oc cinfidence interval and higher bound of confidence interval
  matrix<-matrix(nrow=4,ncol=gen)
  time<-1:gen
  matrix[1,]<-time
  #find confidence intervals for species richness in each generation
  for (k in 1:gen){
    mean<-mean(richness[,k])
    stddev<-sd(richness[,k])
    error <- qnorm(0.986)*stddev/sqrt(n)
    lower<-mean-error
    higher<-mean+error
    matrix[2,k]<-mean
    matrix[3,k]<-lower
    matrix[4,k]<-higher
  }
  #convert to dataframe
  matrix<-as.data.frame(t(matrix))
  colnames(matrix)<-c("time","mean","low","high")
  
  return(matrix)
}
# Challenge question A
Challenge_A <- function() {
  graphics.off()
  #make function which plots community by calling calc function
  plotcommunity<-function(community){
  graphics.off()
  matrix<-calc(200,community)
  print(ggplot(data=matrix,aes(x=time,y=mean), colour="black") +
      geom_point()+theme_bw()+geom_line()+
      geom_errorbar(aes(ymin=low, ymax=high, width=.1),color="blue")+
      geom_vline(xintercept=50,color="red"))
  }
  #plot for init_community max 
  community<-init_community_max(100)
  plotcommunity(community)
  community<-init_community_min(100)
  plotcommunity(community)
  

}
# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  means<-matrix(nrow=10,ncol=200)
  colnames(means)<-1:200
  #function to make a matrix for possible initial communities
  makecommunitymatrix<-function(communitylength){
    listfact<-vector()
    #for each from 1 to length of community, if factor of community length, add to list
    for (i in (1:communitylength)){
      if (communitylength%%i==0){
        listfact<-c(listfact,i)
      }
    }
    communitymatrix<-matrix(nrow=length(listfact),ncol=communitylength)
    k=1
    #fil listfact with repetitions of 1:each factor
    for(j in listfact){
      fill<-1:j
      communitymatrix[k,]<-fill
      k=k+1
    }
   return(communitymatrix)
  }
#work out possible initial communities for a community size 100
communitymatrix<-makecommunitymatrix(100)
gen<-200
#make plotting function
plotting<-function(communitymatrix,gen){
  toplot<-as.data.frame(matrix(nrow=nrow(communitymatrix)*gen,ncol=3))
  q=0
  #for each community
  for (row in (1:nrow(communitymatrix))){
    community<-communitymatrix[row,]
    matrix<-calc(gen,community)  #calculate mean and confidence intervals for each community
    toplot[(q+1):(gen+q),1]<-matrix[,2] #mean in toplot matrix for each generation
    toplot[(q+1):(gen+q),3]<-max(community)#community size in toplot
    #index end of data for each community
    q<-gen+q
  }
  #generation added to toplot
  toplot[,2]<-rep(1:gen,nrow(communitymatrix))
  colnames(toplot)<-c("Mean_Species_Richness","Generation","initial_species_number")
  toplot$initial_species_number<-as.factor(toplot$initial_species_number)
  #plot on graph
  print(ggplot(data=toplot,aes(x=Generation,y=Mean_Species_Richness,colour=initial_species_number))+geom_point())
}
#call plotting function
plotting(communitymatrix,gen)
}
# Challenge question C  
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  #initialise matrix with number of times species richness was recorded for each size 
  richness_matrix<-matrix(ncol=3,nrow =(3999*25+7999*25+19999*25+39999*25))
  r=0
  #load each file and add richness size and generation number to richness_matrix
  for (i in 1:100){
    file<-paste0("output2_",i,".rda")
    load(file)
    richness_matrix[(r+1):(r+length(richness)),1]<-richness
    richness_matrix[(r+1):(r+length(richness)),2]<-1:length(richness) #generation number
    richness_matrix[(r+1):(r+length(richness)),3]<-size
    #r index ensures next file data is added to matrix immediately after file before
    r=r+length(richness)
  }
    richness_matrix=as.data.frame(richness_matrix)
    colnames(richness_matrix)=c("richness","generation","size")
    size_vector<-c(500,1000,2500,5000)
    #initialise matrix for subsetting and calculating mean richness
    mean_dataframe<-matrix(ncol=3,nrow=3999+7999+19999+39999)
    p=0
    for (s in 1:4){
      #for each size, subset data, then calculate mean. add size and generation to this matrix
       sub<- subset(richness_matrix, size==size_vector[s])
       mean_dataframe[(p+1):(p+(length(unique(sub$generation)))),2]<-tapply(sub$richness, sub$generation,mean)
       mean_dataframe[(p+1):(p+(length(unique(sub$generation)))),1]<-1:(length(unique(sub$generation)))
       mean_dataframe[(p+1):(p+(length(unique(sub$generation)))),3]<-size_vector[s]
       p<-p+(length(unique(sub$generation)))
       }
    #format data
    mean_dataframe=as.data.frame(mean_dataframe)
    colnames(mean_dataframe)=c("Generation","Mean_Species_Richness","Size")
    mean_dataframe$Size<-as.factor(mean_dataframe$Size)
    #plot data
    print(ggplot(data=mean_dataframe,aes(x=Generation,y=Mean_Species_Richness,color=Size))+theme_bw()+geom_point(size=0.1))
    return(0)
  }

# Challenge question D
Challenge_D <- function() {
    graphics.off()
  #function for initialising data
    initialising<-function(J,speciation_rate){
      #initialise vector for lineages
      lineages<-rep(1,J)
      #initialise vector for abundunces
      abundances<-c()
      #initialise N
      N<-J
      #theta calculation
      theta<-speciation_rate*((J-1)/(1-speciation_rate))
      while(N>1){
        #randomly sample poss
        poss<-1:length(lineages)
        j<-sample(x=poss,size=1)
        #calculate random number
        randnum<-runif(1,0,1)
        #depending on value of random number either add sampled species to abundances or...
        if ((randnum)<(theta/(theta+N-1))){
          abundances<-append(abundances,lineages[j])
        }else{
          #or remove that species and resample , then add the value of linages[j] to lineages of the new index
          poss2<-poss[-j]
          i<-sample(x=poss2,size=1)
          lineages[i]<-lineages[i]+lineages[j]
      }
      lineages<-lineages[-j] #remove the species which was randomly sampled
      N<-N-1
      }
      #simulated species abundances data
      abundances<-append(abundances,lineages)
      return(abundances)
    }
      
  octaves_list<-list(vect500=c(0),vect1000=c(0),vect2500=c(0),vect5000=c(0))
  count<-list(vect500=0,vect1000=0,vect2500=0,vect5000=0)
  sizes<-c(500,1000,2500,5000)
  #below was for calculating comparison time
  octave_number<-c(942522, 202368, 21226, 1975)
  octave_number<-octave_number/100
  #simulate abundance for each size (depending on value in octave_number)
   for (j in 1:4){
    for (k in 1:octave_number[j]){
    abundances<-initialising(J=sizes[j],speciation_rate = personal_speciation_rate)
  oct<-octaves(abundances)
  octaves_list[[j]]<-sum_vect(octaves_list[[j]],oct)
  count[[j]]<-count[[j]]+1
    }
   }
  #average abundance
  combined_results<-list(0,0,0,0)
  for (k in (1:length(octaves_list))){
    combined_results[[k]]<-octaves_list[[k]]/count[[k]]
  } 
  #plot
  par(mfrow=c(2,2))
  barplot(combined_results[[1]],main="Size=500",xlab="Species Abundance Octave",ylab="Mean frequency") 
  barplot(combined_results[[2]],main="Size=1000",xlab="Species Abundance Octave",ylab="Mean frequency")
  barplot(combined_results[[3]],main="Size=2500",xlab="Species Abundance Octave",ylab="Mean frequency")
  barplot(combined_results[[4]],main="Size=5000",xlab="Species Abundance Octave",ylab="Mean frequency")

  return("1200 CPU hours were used initially. The coalescence mathod takes significantly less time. When 25 simulations are carried out for each size, this only takes 10.44 seconds but this is an underestimate. An equivalent number of simulations took 6.45 hours using the coalescence method for each of the octaves for each simulation, however this is an undermestimate because there is autocorrelation between octaves. ")
}

# Challenge question E
Challenge_E <- function() {
  graphics.off()
  # clear any existing graphs and plot your graph within the R window
  # coordinates
  x<-c(0,0)
  A<-c(2,0)
  B<-c(-2,0)
  C<-c(0,sqrt(12))
  options<-list(A,B,C)
  plot(x[1],x[2],cex=0.0001,xlim=c(-2,2),ylim = c(0,4))
  for (i in 1:5000){
    
    s<-sample(options,1)
    s<-(s[[1]])
    x<-(x+s)/2    
    points(x[1],x[2],cex=0.0001,col="dark green")
  }
    for (i in 1:50000){
      s<-sample(options,1)
      s<-(s[[1]])
      x<-(x+s)/2    
      points(x[1],x[2],cex=0.0001,col="red")
  }
  
  
  return("changing the initial value has no effect on the final shape. changing the colour of the first few values showed that values jumped around the points of the triangle and initial results were different each time")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  par(mfrow=c(3,2))
  #varying line threshold

  fern_large_threshhold <- function(start_position, direction, length,dir)  {
    start_position<-turtle(start_position,direction,length,"purple") 
    if (length>0.1){
      #direction changes each time
      fern_large_threshhold(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir=dir)
      fern_large_threshhold(start_position=start_position,direction=direction,length=length*0.87,dir=-dir)
    }
  }
    plot(c(-2,2),c(0,8),xlab=" ", ylab=" ","n")
    fern_large_threshhold(start_position = c(0,0), direction=pi/2, length=1,dir=1)
    
   fern_small_threshhold <- function(start_position, direction, length,dir)  {
    start_position<-turtle(start_position,direction,length,"purple") 
    if (length>0.001){
      #direction changes each time
      fern_small_threshhold(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir=dir)
      fern_small_threshhold(start_position=start_position,direction=direction,length=length*0.87,dir=-dir)
    }
  }
    plot(c(-2,2),c(0,8),xlab=" ", ylab=" ","n")
    fern_small_threshhold(start_position = c(0,0), direction=pi/2, length=1,dir=1)
   
  fernA <- function(start_position, direction, length)  {
    start_position<-turtle(start_position,direction,length,"orange") 
    if (length>0.01){
      fernA(start_position=start_position,direction=direction-pi/4,length=length*0.38)
      fernA(start_position=start_position,direction=direction,length=length*0.87)
    }
  }
  plot(c(0,2),c(-1,8),xlab=" ", ylab=" ","n")
  fernA(start_position = c(0,0), direction=pi/2, length=1)
  
  fern2B <- function(start_position, direction, length,dir)  {
    start_position<-turtle(start_position,direction,length,"blue") 
    if (length>0.01){
      fern2B(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir=-1)
      fern2B(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.87,dir==1)
    }
  }
  plot(c(-4,1),c(-1,5),xlab=" ", ylab=" ","n")
  fern2B(start_position = c(0,0), direction=pi/2, length=1,dir=1)
  
  
  fern2C <- function(start_position, direction, length,dir)  {
    start_position<-turtle(start_position,direction,length,"purple") 
    if (length>0.01){
      fern2C(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir==-1)
      fern2C(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.87,dir==1)
    }
  }
  plot(c(-1,3),c(-1,4),xlab=" ", ylab=" ","n")
  fern2C(start_position = c(0,0), direction=0, length=1,dir=1)
  
  fern2D <- function(start_position, direction, length,dir)  {
    start_position<-turtle(start_position,direction,length,"brown") 
    if (length>0.01){
      fern2D(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir=1)
      fern2D(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.87,dir=-1)
    }
  }
  plot(c(-1,1),c(0,4),xlab=" ", ylab=" ","n")
  fern2D(start_position = c(0,0), direction=pi/2, length=1,dir=1)
  ##first bit, change a and maybe c,
  return("When the line threshold is larger ,the graph is much less detailed because the function will stop branching earlier. when the line threshold is larger ,the fern will be much more detailed but will take significantly longer")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.