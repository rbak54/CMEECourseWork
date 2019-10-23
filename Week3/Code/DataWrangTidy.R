#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: DataWrangTidy.R
#Desc: wrangling data using tidyr and dplyr
#Arguments: none 
#Input: none
#Output: 
#Date: Oct 2019
library(tidyr)
library(plyr)
############# Load the dataset ###############
# header = false because the raw data don't have real headers 
MyData<- as.matrix(read.csv("../Data/PoundHillData.csv",header = F)) 
# header = true because we do have metadata headers- don't want strings as factors 
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

dplyr::tbl_df(MyData)
dim(MyData) 
dplyr::glimpse(MyData)
#utils::View(MyData) 
#utils::View(MyMetaData)
# species into columns and treatments into rows 
MyData <- t(MyData) 
#replace with 0s
MyData[MyData == ""] = 0
#MyData<-tidyr::replace(MyData, 0)
#convert to data frame
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data
#wide to long
MyPivotData<-TempData %>% 
  gather(5:45, key="Species", value = "count")
#utils::View(MyPivotData)

#MyPivotData[, "Cultivation"] <- as.factor(MyPivotData[, "Cultivation"])
#MyPivotData[, "Block"] <- as.factor(MyPivotData[, "Block"])
#MyPivotData[, "Plot"] <- as.factor(MyPivotData[, "Plot"])
#MyPivotData[, "Quadrat"] <- as.factor(MyPivotData[, "Quadrat"])
#MyPivotData[, "Count"] <- as.integer(MyPivotData[, "Count"])

dplyr::tbl_df(MyPivotData)
#utils::View(MyPivotData)
#str(MyWrangledData)
#head(MyWrangledData)
#dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############
#MyData[MyData==""]=0
#head(MyData)
