#include <stdio.h>

int main(void)
{
    int x = 0;
    char a = '\0'; //ascII representation for 0
    char b = 0;
    char c = '0';
//above '0', 0, and '/0' as a char
  /*  printf("As char %c\n", a);
    printf("As char %c\n", b);
    printf("As char %c\n", c);*/
//above '0', 0, and '/0' as a char
  /*  printf("As int %i\n", a);
    printf("As int %i", b);
    printf("As int %i\n", c);*/
//above strange!
    x = 255;
    a = x;
    x = a; //same with or without
    printf("255 passed through char back into int %i\n", a);

    x = 256;
    a = x;
    x = a; //same with or without
    printf("256 passed through char back into int %i\n", a);
//255 =-1
//256 =0
//character is only capable of holding 255, so truncated

// if treat as unsigned int
//255 can be treated as character, 256 is one too big. uses >8  thins, truncated
//best to use signed -even if not expecting bc it can help find bugs.
//specifying unsigned- got 0
    return 0;
}