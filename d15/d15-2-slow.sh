#!/bin/bash

for ((i=0; ; i+= 1)); do
  [[ $(((i+1+10)%13)) -eq 0 ]] &&
  [[ $(((i+2+15)%17)) -eq 0 ]] &&
  [[ $(((i+3+17)%19)) -eq 0 ]] &&
  [[ $(((i+4+1)%7)) -eq 0 ]] &&
  [[ $(((i+5+0)%5)) -eq 0 ]] &&
  [[ $(((i+6+1)%3)) -eq 0 ]] &&
  [[ $(((i+7+0)%11)) -eq 0 ]] &&
    echo $i && exit
done
