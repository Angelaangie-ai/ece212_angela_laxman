

#include "ece212.h"

/*
 * 
 */
int main() {
    
    ece212_lafbot_setup();

    while (1) {
        RFORWARD = 0x7fff;
        LFORWARD = 0x7fff;
        RBACK = 0;
        LBACK = 0;
        delayms(500);

        RFORWARD = 0;
        LFORWARD = 0;
        RBACK = 0;
        LBACK = 0;
        delayms(1000);

        RFORWARD = 0;
        LFORWARD = 0;
        RBACK = 0x7fff;
        LBACK = 0x7fff;
        delayms(500);

        RFORWARD = 0;
        LFORWARD = 0;
        RBACK = 0;
        LBACK = 0;
        delayms(1000);
    }
    
    return (EXIT_SUCCESS);
}

