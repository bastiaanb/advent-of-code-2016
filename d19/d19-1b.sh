#!/bin/bash

elfs=$1

stepsize=1
startelf=1
offset=1

while [[ $elfs -gt 1 ]]; do
  echo "elfs: $elfs: startelf: $startelf offset: $offset"
  if [[ $offset -eq 0 ]]; then
    ((startelf+=stepsize))
  fi
  ((odd=elfs%2))
  ((elfs=(elfs+offset)/2))
  ((offset=(odd+offset)%2))
  ((stepsize+=stepsize))
  echo "odd: $odd offset: $offset"
done

  if [[ $offset -eq 0 ]]; then
    ((startelf+=stepsize))
  fi
echo "winner: $startelf"




# 1
# o 12345   o
# 1 .x.x.   0  3
# 0 x.x.x   1  2
#
# 0
# o 1234    0
# 1 .x.x    1  2
# 0 x.x.    0  2
