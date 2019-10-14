#!/bin/bash
touch readme.md
echo -e "# Directory Content for This Week" >>./readme.md
echo -e "\n">>./readme.md
cd Code
all=`ls *.*`
for each in $all
do
    echo -e "##" $each >> ../readme.md
    echo -e "\n\n" >> ../readme.md
    grep -i "Desc:" $each | tr -d "#" >> ../readme.md
    echo -e "\n \n" >>../readme.md
    grep -i "Arguments:" $each | tr -d "#" >> ../readme.md
    echo -e "\n \n" >> ../readme.md
    grep -i "Output:" $each | tr -d "#" >> ../readme.md
done
exit
