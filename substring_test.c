/* ********************************
 * CSE 30 - HW 3
 * ********************************/
#include <assert.h>
#include <stdio.h>
#include "substring.h"

int main() {
    // multiple test cases for substring
    char * tester1 = "ABCDE";
    char * tester2 = "CDE";
    char * tester3 = "ABE";
    char * tester4 = "ABCDEF";
    char * tester5 = "D";
    assert(substring(tester1,tester2)==1);
    assert(substring(tester1,tester1)==1);
    assert(substring(tester1,tester3)==0);
    assert(substring(tester1,tester4)==1);
    assert(substring(tester1,tester5)==1);
    assert(substring(tester5,tester3)==0);
    assert(substring("BCDE","ABCD")==0);
    printf("substring tests passed\n");
    return 0;
}
