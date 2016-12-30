#!/bin/bash

for((stepsize=1, startelf=1, offset=1, elfs=$1; elfs > 1; stepsize*=2)); do ((
  startelf+=(1 - offset) * stepsize,
  remainder=elfs % 2,
  elfs=(elfs + offset) / 2,
  offset=(remainder + offset) % 2
)) done

echo $startelf
