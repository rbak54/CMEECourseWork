
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: TAutoCorr.R 
#Desc: 
#Arguments: 
#Input: 
#Output: 
#Date: Oct 2019

utocorrelation in weather (this Practical assumes you know about correlation coefficients and p-values). Your goal is to write an R script that will help answer the question: Are temperatures of one year significantly correlated with the next year (successive years), across years in a given location? For this, you need to calculate the correlation between n−1 pairs of years, where n

is the total number of years. However, you can't use the standard p-value calculated for a correlation coefficient, because measurements of climatic variables in successive time-points in a time series (successive seconds, minutes, hours, months, years, etc.) are not independent. The general guidelines are:

    Make a new script named TAutoCorr.R, and save in codedirectory
    At the start of the script, load and examine and plot KeyWestAnnualMeanTemperature.Rdata, using load(). This is the temperature in Key West, Florida for the 20th century.
    Now extend the script to:
        Compute the appropriate correlation coefficient between successive years and store it (look at the help file for cor()
        Repeat this calculation 10000 times by -- randomly permuting the time series, and then recalculating the correlation coefficient for each randomly permuted year sequence and storing it. Hint: you can use the sample function that we learned about). Read the help file for this function and experiment with it.
        Then calculate what fraction of the correlation coefficients from the previous step were greater than that from step 1 (this is your approximate p-value).
    How do you interpret these results? Why? Present your results and their interpretation in a pdf document written in LATEX

(please include the the document's source code as well).

load("/home/ruth/Documents/CMEECourseWork/Week3/Data/KeyWestAnnualMeanTemperature.RData")
