#!/bin/bash

((
f1=8, f2=2, f3=0,
part1=(f1 - 2) * 2 + 1 + (f1 + f2 - 2) * 2 + 1 + (f1 + f2 + f3 - 2) * 2 + 1,
f1+=4,
part2=(f1 - 2) * 2 + 1 + (f1 + f2 - 2) * 2 + 1 + (f1 + f2 + f3 - 2) * 2 + 1
))

echo $part1
echo $part2
