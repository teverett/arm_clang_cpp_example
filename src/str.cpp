
#include "str.hpp"

extern "C"  int strlen(const char* s)
{
    int result = 0;
    while (*s++) ++result;
    return result;
}

 extern "C" void reverse(char s[])
 {
     int i, j;
     char c;
 
     for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
         c = s[i];
         s[i] = s[j];
         s[j] = c;
     }
 }

 extern "C" void itoa(int n, char s[])
 {
    int i, sign;
 
     if ((sign = n) < 0)  
         n = -n;         
     i = 0;
     do {      
         s[i++] = n % 10 + '0';  
     } while ((n /= 10) > 0);     
     if (sign < 0)
         s[i++] = '-';
     s[i] = '\0';
     reverse(s);
 }




