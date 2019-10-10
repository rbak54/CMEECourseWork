import os
import re
directory='Documents/CMEECourseWork/Week1/Code'
g=open("Documents/CMEECourseWork/Week1/readme.md","w+")
g.write("Directory content for this week")
for filename in os.listdir(directory):
    g.write(filename) 
    g.write("\n")
    g.write(re.findall(r"Desc:",line))
  #next somehow want to add description  
g.close()
