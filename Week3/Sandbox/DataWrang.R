MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header= F, stringsAsFactors = F))
MetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F )
class(MyData)
head(MyData)
