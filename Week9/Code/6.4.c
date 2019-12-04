//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: 6.4.c
//Desc: counting from 0 to 10
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>

// int countto (int n)
// {
//     int n_n;
//     if (n) {
//         n_n=countto(n-1);
//         return n + n_n;
//     }
//     return 0;
//}
int countto(int n)
{
    //int m = 1;
    //int n_n;
    if (m<= 10) {
        printf("%i ",m);
        //n_n=countto(n-1);
        m=countto(m-1)
        return 0;
    }
}
int main (void)
{
    int a = 0;
    countto(10);
  //  a=countto(10);
 //   printf("answer is : %i",a);
    return 0;
}
