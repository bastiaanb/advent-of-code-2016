#!/bin/bash

possible=0

ispossible() {
  [[ $(($1 + $2)) -gt $3 ]] && \
  [[ $(($1 + $3)) -gt $2 ]] && \
  [[ $(($2 + $3)) -gt $1 ]]
}

while read s11 s21 s31 ; do
  read s12 s22 s32
  read s13 s23 s33
  ispossible $s11 $s12 $s13 && ((possible++))
  ispossible $s21 $s22 $s23 && ((possible++))
  ispossible $s31 $s32 $s33 && ((possible++))
done
echo "possible $possible"
