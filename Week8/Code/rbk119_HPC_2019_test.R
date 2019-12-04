#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: rbk119_HPC_2019_challengeG.R
#Desc: test for HPC
#Arguments: none
#Input: none
#Output: none
#Date: NOv 2019

rm(list=ls()) # good practice 
source("rbk119_HPC_2019_main.R")
# it should take a faction of a second to source your file
# if it takes longer you're using the main file to do actual simulations
# it should be used only for defining functions that will be useful for your cluster run and which will be marked automatically

# do what you like here to test your functions (this won't be marked)
# for example
species_richness(c(1,4,4,5,1,6,1))
# should return 4 when you've written the function correctly for question 1
init_community_max(7)

init_community_min(6)

species_richness(init_community_max(6))
species_richness(init_community_min(4))
# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied up by the time it's made its way into the main.R file or other files.
neutral_step(c(10,5,13))
neutral_generation(c(6,9,3,8,10))
