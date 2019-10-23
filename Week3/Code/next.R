#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: next.R
#Desc: use of next. between 1 and 10, if i is divible by 2 then do not print, otherwise print
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
for (i in 1:10) {
    if ((i %%2)==0)  #if even, then skip
      next
    print(i)
}