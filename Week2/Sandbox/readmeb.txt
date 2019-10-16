#!/bin/bash
###be in week2
touch readme.md
#replaces file
echo -e "# Directory Content for This Week" >./readme.md
echo -e "\n">>./readme.md
cd Code
all=`ls *.*`
for each in $all
do
    echo -e "##" $each >> ../readme.md
    echo -e "\n\n" >> ../readme.md
    grep -i "Desc:" $each | tr -d "#" >> ../readme.md
    echo -e "\n \n" >>../readme.md
    grep -i "Input:" $each | tr -d "#" >> ../readme.md
    echo -e "\n \n" >> ../readme.md
    grep -i "Output:" $each | tr -d "#" >> ../readme.md
done
cd ../
#deletes and makes new results . adds readme
rm -r Results
mkdir Results
cd Results
touch readme.txt
cd ../
exit
