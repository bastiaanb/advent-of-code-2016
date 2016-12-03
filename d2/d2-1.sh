#!/bin/bash

declare -A move
move=([L]=-1 [R]=1 [U]=-5 [D]=5)

lock="\
-----\
-123-\
-456-\
-789-\
-----"

p=12
while read l ; do
  for i in $(seq 0 $((${#l} -1)) ) ; do
    s=${l:$i:1}
    n=$((p + ${move[$s]}))
    [[ "${lock:$n:1}" == "-" ]] || p=$n
  done
  echo -n "${lock:$p:1}"
done
echo
