//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: primecountfunctino.c
//Desc: countingprimes just function
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019

#include <stdio.h>

int count_primes_C(int limit)
{
    int prime=1;
    int divisor=2;
    int is_prime=0;
    int n_primes=0;

    while (prime<limit){
        is_prime=0;

        for (divisor=2;divisor <= prime / 2 ; ++divisor){  //hald because 10/7 doesnt divide evenlty
            if (prime % divisor==0){
                is_prime=1;
                break;
            }
        }
            if (is_prime==0){
                ++n_primes;
            }
        ++prime;
    }
 return n_primes;
}