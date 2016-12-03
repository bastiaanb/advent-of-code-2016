#!/bin/bash

((LX=0, LY=0))
((DY=1, DX=0))

declare -A rot
rot=([L]=-1 [R]=1)

step=0
for i in $(sed 's/,//g'); do
  r=${i:0:1}
  l=${i:1}
  NDY=$((-1 * rot[$r] * $DX))
  DX=$((rot[$r] * $DY))
  DY=$NDY
  LX=$(($LX + $l * $DX))
  LY=$(($LY + $l * $DY))
  ((step++))
done
echo $((${LX#-} + ${LY#-}))
