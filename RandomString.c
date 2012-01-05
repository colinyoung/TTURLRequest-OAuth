// 2012 Colin Young
// WTFPL License
// http://sam.zoy.org/wtfpl/

#include "RandomString.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *randomStringOfLength(int length) {
    
    unsigned char alphanumeric[36] = {"abcdefghijklmnopqrstuvwxyz0123456789"};
    char dest[100] = {0};
    
    int i = 0;
    for (; i < length; i++) {
        char s[2] = {0};
        u_int32_t j = arc4random() % 36;
        s[0] = alphanumeric[j];
        s[1] = 0;
        strcat(dest, s);
    }
    
    char *p;
    p = &dest[0];
    
    return p;
}
