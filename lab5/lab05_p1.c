/* 
 * File:   lab5_p1.c
 * Author: labella
 *
 * Created on February 22, 2022, 1:19 PM
 */

#include "ece212.h"

/*
 * 
 */
int main() {
    
    ece212_setup();
    
    int flip = 1;
    int i = 1;
    int last = 0;
    
       
    
    
    while (1) { 
        
        if (BTN11 && !last) { //the button is pressed
                flip = !flip; //now flip
            }
        last = BTN11;
        
        writeLEDs(i);
         
        if (flip) { //if flip increment by multiplying by 2 to get 1, 2, 4, 8
            i *= 2;
            delayms(100);
            if (i > 8) {
                i = 1;
            }
        } else { 
            i /= 2; //decrement by dividing by 2 to get 8, 4, 2, 1
            delayms(100);
            if (i < 1) {
                i = 8;
            }
        }
    }

    return (EXIT_SUCCESS);
}
