#!/bin/bash

rot=([L]=left [R]=right)

echo "pendown"
for i in $(sed 's/,//g'); do
  r=${i:0:1}
  l=${i:1}

  echo "${rot[$r]} 90"
  echo "forward $l"
done
