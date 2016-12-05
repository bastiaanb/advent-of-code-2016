#!/bin/bash

prefix=$1

batch_size=10000
tmpdir=/tmp/d5

install -d $tmpdir

code=(_ _ _ _ _ _ _ _)
index=0
count=0
for ((index=0 ; ; index++)) ; do
  i=$((index % batch_size))
  echo -n "$prefix$index" > $tmpdir/$i
  if [[ $i -eq $((batch_size - 1)) ]] ; then
    echo md5 $index
    for found in $(md5sum $tmpdir/* | grep '^00000[0-7]' | sed 's/ /./g') ; do
      position="${found:5:1}"
      digit="${found:6:1}"
      echo "FOUND $found: $digit for $position"
      if [[ ${code[$position]} == "_" ]] ; then
        code[$position]=$digit
        echo "${code[@]}"
        ((count++))
        [[ $count -ge 8 ]] && exit
      fi
    done
  fi
done
