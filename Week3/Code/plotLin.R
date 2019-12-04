#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: plotLin.R
#Desc: makes plot
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
graphics.off()
require("ggplot2")
x <- seq(0, 100, by = 0.1)
y <- -4. + 0.25 * x +
  rnorm(length(x), mean = 0., sd = 2.5)
# a dataframe
my_data <- data.frame(x = x, y = y)

#linear regression
my_lm<-summary(lm(y~x, data=my_data))
# plot data
p<- ggplot(my_data, aes(x=x, y=y,
                        colour=abs(my_lm$residual))
      )+
      geom_point()+
      scale_colour_gradient(low="black", high="red") +
      theme(legend.position = "none")+
      scale_x_continuous(
        expression(alpha^2 * pi/beta * sqrt(Theta)))
#add regression line
p<- p + geom_abline(
  intercept=my_lm$coefficients[1][1],
  slope=my_lm$coefficients[2][1],
  colour="red")
#math
p<- p+ geom_text(aes(x=60, y=0,
                    label="sqrt(alpha) *2 * pi"),
                    parse=TRUE, size=6,
                   colour="blue")
p
#prints pdf
pdf("../Results/MyLinReg.pdf") # Open blank pdf page using a relative path
print(p)
graphics.off()
print("plot saved as MyLinReg.pdf in results")