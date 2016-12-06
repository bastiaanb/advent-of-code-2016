#!/bin/bash

input=$1
read line < $input
length=${#line}

for i in $(seq 1 $length) ; do
  cut -b $i < $input | sort | uniq -c | sort -r -n  | head -1 | egrep -o '.$'
done
