/* 
 * File:   lab06.c
 * Author: busheska
 *
 * Created on October 18, 2022, 8:30 AM
 */

#include "ece212.h"

/*
 * 
 */
int main() {

    ece212_lafbot_setup();
    
    int s1 = 0;
    int s2 = 0;
    
    delayms(10);
    while(1) {
    
        s1 = (analogRead(LEFT_SENSOR) > 350);
        s2 = (analogRead(RIGHT_SENSOR) > 350);
        writeLEDs((s2 << 3) | s1);
        //over white
        //overwhite 
        if (s1) {
            RBACK = 0;
            LBACK = 0;
            RFORWARD = 0xffff;
            LFORWARD = 0x1fff;
        } else if (s2) {
            RBACK = 0;
            LBACK = 0;
            RFORWARD = 0x1fff;
            LFORWARD = 0xffff;
        } else if (s1 && s2) {
            RBACK = 0;
            LBACK = 0;
            RFORWARD = 0x1fff;
            LFORWARD = 0x1fff;
        } else {
            RBACK = 0;
            LBACK = 0;
            RFORWARD = 0xffff;
            LFORWARD = 0xffff;
        }
        delayms(2);
    
    }
    return (EXIT_SUCCESS);
}

