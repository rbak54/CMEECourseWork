//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: loops.c
//Desc: intro to loops 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>

int main(void)
{
    int i = 0;
    int intarray[]= {4, 8, 5, 44};
    char hello[] = "Hello!";

    //while loop
    while (i < 4){ //while condition is non-zero ,execute code between {}
        printf("%i", intarray[i]);
        ++i;
    }
    printf("\n");
i=0;
    do {
        printf("%i", intarray[i]);
        ++i;
    } while (i<4);
    
printf("\n");

printf("using a for-loop:\n");
    for (i=0; i<4; i++) {
        printf("%i ",intarray[i]);
    }
printf("\n");

printf("Read an array backwards: \n");
for (i=3; i>=0; --i) {
    printf("%i ", intarray[i]);
}

printf("\n");
for (i=4; i--; ) {  // continues to non 0 value (0 )
    printf("%i ", intarray[i]);
}

printf("\n");
//Three ways to print a string
//char hello[] = "Hello!";
for (i=0; i<6; ++i) {
    putchar(hello[i]);
}
printf("\n");

for (i=0; hello[i]; ++i) {  //null terminated so dont need to know length
    putchar(hello[i]);
}
printf("\n");

//printf(hello); //not perfect- being pendantic but R warnings
printf("%s", hello);

printf("\n");
return 0;
}
