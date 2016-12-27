#!/bin/bash

elfs=$(($1 - 1))
pow=1
while [[ $elfs -ge $pow ]]; do
  ((pow*=3))
done

((pow/=3))
((remainder=elfs%pow))
if [[ $elfs -ge $((pow+pow)) ]]; then
  ((winner=pow+1+2*remainder))
else
  ((winner=remainder))
fi
echo $((winner+1))
