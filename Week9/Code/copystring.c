//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: copystring.c
//Desc: copies a string 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <string.h>

int main (void)
{
    char dest[10];
    char message[]= "Uh oh!";
    strcpy(dest,message);
    printf("%s\n",dest);

    return 0;
}
