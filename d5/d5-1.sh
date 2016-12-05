#!/bin/bash

prefix=$1

install -d tmp

code=""
index=0
batch_size=10000
digit=0
for ((index=0 ; ; index++)) ; do
  i=$((index % batch_size))
  echo -n "$prefix$index" > tmp/$i
  if [[ $i -eq $((batch_size - 1)) ]] ; then
    echo do md5 $index
    for found in $(md5sum tmp/* | grep '^00000' | sed 's/ /./g') ; do
      echo "FOUND $found: ${found:5:1}"
      code="${code}${found:5:1}"
      ((digit++))
      if [[ $digit -ge 8 ]] ; then
        echo CODE $code
        exit
      fi
    done
  fi
done
