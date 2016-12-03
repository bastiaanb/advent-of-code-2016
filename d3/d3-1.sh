#!/bin/bash

possible=0

ispossible() {
  [[ $(($1 + $2)) -gt $3 ]] && \
  [[ $(($1 + $3)) -gt $2 ]] && \
  [[ $(($2 + $3)) -gt $1 ]]
}

while read s1 s2 s3 ; do
  ispossible $s1 $s2 $s3 && ((possible++))
done
echo "possible $possible"
