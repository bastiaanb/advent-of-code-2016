#!/bin/bash

for((pow=1, elfs=$1 - 1; elfs >= pow * 3; pow*=3 )); do true; done

echo $(( (elfs / pow) * (1 + pow + elfs % pow) - pow ))
