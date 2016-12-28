#!/bin/bash

elfs=$1

stepsize=1
startelf=1
offset=1

while [[ $elfs -gt 1 ]]; do
#  echo "elfs: $elfs: startelf: $startelf offset: $offset"
  if [[ $offset -eq 0 ]]; then
    ((startelf+=stepsize))
  fi
  ((odd=elfs%2))
  ((elfs=(elfs+offset)/2))
  ((offset=(odd+offset)%2))
  ((stepsize+=stepsize))
done

echo "winner: $startelf"
