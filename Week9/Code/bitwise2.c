//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: bitwise2.c
//Desc:  exploring bitwise operations 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>

    /* 
     *
     * A: 0001
     * C: 0010
     * G: 0100
     * T: 1000
     * ?: 1111
     * */ 

unsigned char pack_dna(char in)  //smallest poss is byt so well use that
{
    if (in == 'A'){
        return (unsigned char)1;
    }
    else if (in == 'C'){
        return (unsigned char)1 << 1;
    }
    else if (in == 'G'){
        return (unsigned char)1 << 2;
    }
    else if (in == 'T'){
        return (unsigned char)1 <<3 ;
    }
    else if (in == '?'){
         return (unsigned char)~0;
    }
}

int main (void)
{
    char *alignment[]=
    {
        "AAAAAA"
        "CAACGA"
        "ATTAGA"

        //if want fischs logic on a position by position basis. need to find a way to conv bases into binary. need a convention!
    };

    int ntax = 3;
    int nsites = 6;
    char packed[ntax][nsites];  // note variable sized arrays not portable
    // matrix of strings to characters (pointers)
    //unsigned operators here
}