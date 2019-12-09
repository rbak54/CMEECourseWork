#include <R.h>
#include <Rdefines.h>
#include "countprimes.h"

SEXP count_primes_C_wrap(SEXP limit)
{
    SEXP result;
    PROTECT(result=NEW_INTEGER(1)); //Protect instructs R garbage collecter to leave this data alone. 

    int limit_c=0;
    limit_c=*(INTEGER(limit)); //tells compiler to read the limit arg
    
    int c_result=count_primes_C(limit_c);
    *(INTEGER(result))=c_result;

    UNPROTECT(1); //otherwise you get a stack imbalace - protect is stack- have to balance protect and unprotect
    return result;
}