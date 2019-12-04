//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: strings.c
//Desc: intro to strings 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
int main(void)
{
    char charray[] = {'a', ' ', 's', 't', 'r', 'i','n','g','!','\0'}; //end of string is \0
    char string1[] = "A string!";

    printf("The 9th element of charray: %c\n", charray[9]);
    printf("The 9th element of a string: %c\n", string1[9]);
///????
    return 0;
}
