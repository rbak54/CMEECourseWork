#/bin/bash
texcount main.tex > ../Results/file.txt
grep "Words in text" ../Results/file.txt >../Results/Tables/wordcount.txt
echo "done"