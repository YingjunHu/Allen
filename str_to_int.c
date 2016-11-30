#include <stdio.h>



int str_to_int(char * str, int * dest)
{
   int result = 0;
   if(!str || !dest) return 0;
   int negative = 0;

   if(*str == '-')
   {
      negative = 1;
      str++;
   }
   if(!*str) return 0;
   while(*str)
   {
      result*=10;
      char currentChar = *str;
      int currentInt = currentChar - '0';
      if(currentInt>9 || currentInt<0) return 0;
      result += currentInt;
      str++;
   }
   if(negative)
   {
      result = 0-result;
   }
   *dest = result;
   return 1;
}
