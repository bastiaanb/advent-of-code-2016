#!/bin/bash

line=$1
times=${2:-10}

count=0
for((c=0; c < times; c++)); do
  safe=${line//^}
  ((count+=${#safe}))
  printf "%2d: %s %d\n" $c $line $count
  line=$(perl -pe 's/(?<=(.)).(?!\1)/X/g; tr/X^/^./; s/^.(.*).$/$1/' <<< ".$line.")
done
