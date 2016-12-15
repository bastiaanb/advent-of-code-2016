#!/bin/bash

# Disc 5 has to be 0 at t=5
# Disc 2 has to be 0 at t=2
# => use increments of 5 * 17 = 85
# Disc 6 has to be 1 at t=6
# Disc 3 has to be 1 at t=3
# => use modulo 3*19 = 57 for 1 test
for((i=0;(i+1)%57+(i+11)%13+(i+7)%11+(i+5)%7>0; i+=85)); do true; done && echo $i
