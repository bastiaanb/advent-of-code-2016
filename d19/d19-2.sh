#!/bin/bash

elfs=$(($1 - 1))
for((pow=1; elfs >= pow; pow*=3 )); do true; done
((
  pow/=3,
  remainder=elfs%pow,
  winner=remainder + ((elfs/pow)-1) * (pow + 1 + remainder)
))

echo $((winner+1))
