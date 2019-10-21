#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: DataWrangTidy.R
#Desc: wrangling data using tidyr and dplyr
#Arguments: none 
#Input: none
#Output: 
#Date: Oct 2019
#Write a new script called DataWrangTidy.R that uses
#dplyr and tidyr for the same data wrangling steps. 
#The best way to do this is to copy DataWrang.R and rename 
#it DataWrangTidy.R. Then systematically redo the script from 
#start to end, looking for a function in dplyr and tidyr that
#does the same thing in each wrangling step.
#For example, to convert from wide to long format, instead of 
#using melt() (or dcast()) from the reshape2 package, you can
#use gather() from tidyr.
library(tidyr)
library(plyr)
############# Load the dataset ###############
# header = false because the raw data don't have real headers 
MyData<- as.matrix(read.csv("../Data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers- don't want strings as factors 
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Inspect the dataset ###############
dplyr::tbl_df(MyData)
dim(MyData) #####################can't find alternative but doesn't seem to be part of data wrangling
dplyr::glimpse(MyData)
utils::View(MyData) #you can also do this
utils::View(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
#MyDataFrame<-as.data.frame(MyData,stringsAsFactors = F)
#tibble::rownames_to_column(MyDataFrame, var="v1") ##can't find alternative
#utils::View(MyDataFrame)

#head(MyData)
#dim(MyData)

############# Replace species absences with zeros ###############
#MyData[MyData == ""] = 0
tidyr::replace_na(MyData, 0)
############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
#require(reshape2) # load the reshape2 package

#?melt #check out the melt function
#MyWrangledData<-tidyr::gather(TempData,"Cultivation","Block","Plot","Quadrat")
MyPivotData<-tidyr::pivot_longer(TempData,TempData[,2])
##above working!!--not right
utils::View(MyWrangledData)
#MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############
MyData[MyData==""]=0
head(MyData)
