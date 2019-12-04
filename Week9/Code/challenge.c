//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: challenge.c
//Desc: convert upper to lower case
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <ctype.h>
int main(void)
{
char c = 'R';
char res= 'A';
res= tolower(c);
printf("Lower case of %c = %c\n", c, res);
return 0;

}
