#!/bin/bash

# for speed
export LC_ALL=C

a=$1
l=$2

# dragonize
while [[ ${#a} -lt $l ]]; do
  a+="0$(rev <<< $a | tr 01 10)"
done

# cut to length
a=${a:0:$l}

# checksum
while [[ $((${#a}%2)) -eq 0 ]]; do
  a=$(perl -pe 's/(..)/:$1/g; s/:(.)(?=\1)./1/g; s/:[01]{2}/0/g;' <<< $a)
done

echo $a
