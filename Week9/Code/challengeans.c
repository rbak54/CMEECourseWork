//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: challengeans.c
//Desc: converting uppercase to lowercase better 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
int main(void)
{
char cap = '\0';
char res= 'A'-'a';

printf("input a capital character: ");
cap = getchar();
// //get char. if >1 time, need to "flush the buffer"
//naive way
// if (cap>='A'){
//     if (cap <= 'Z')   {
//     printf("Lower case of %c = %c\n", cap,cap-res);
//     }
//     else {
//         printf("Input out of range; enter a capital letter \n");
//     }
// }
//  else {
//         printf("Input out of range; enter a capital letter \n");
//     }
// return 0;

// }
//get char. if >1 time, need to "flush the buffer"

if (cap>='A' && cap<='Z'){
    printf("Lower case of %c = %c\n", cap,cap-res);
    }
    else {
        printf("Input out of range; enter a capital letter \n");
    }
return 0;

}
