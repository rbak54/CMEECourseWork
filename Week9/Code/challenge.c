#include <stdio.h>
#include <ctype.h>
int main(void)
{
char c = 'R';
char res;
res= tolower(c);
printf("Lower case of %c = %c\n", c, res);
return 0;

}