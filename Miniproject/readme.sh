#!/bin/bash

###run from main directory
touch readme.md
#replaces file

echo -e "# Choice of languages" >./readme.md
echo -e "\n ##Bash: \nCompiling pdf of tex file \nCalculating word count and storing as a text file using teXcount \nRuning the project\n\n ##Python\nSorting data\nAdding columns\nRemoving very small datasets\n\n##R\nModel fitting\nPlotting graphs\nData analysis\n\n" >./readme.md
echo -e "# Versions of programmes" >./readme.md

echo -e "# Packages used" >./readme.md


#echo -e "# Directory Content" >./readme.md
echo -e "\n">>./readme.md
cd Code
all=`ls *.*`
for each in $all
do
    echo -e "##" $each >> ../readme.md
    echo -e "\n\n" >> ../readme.md
    grep -i "Desc" $each | tr -d "#/" >> ../readme.md
    echo -e "\n \n" >>../readme.md
    grep -i "Input:" $each | tr -d "#/" >> ../readme.md
    echo -e "\n \n" >> ../readme.md
    grep -i "Output:" $each | tr -d "#/" >> ../readme.md
done
cd ../
#deletes and makes new results . adds readme
#rm -r Results
#mkdir Results
cd Results
touch readme.txt
cd ../
exit
