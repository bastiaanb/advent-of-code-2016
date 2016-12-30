moveOneFloor 1     = 1
moveOneFloor 2     = 1
moveOneFloor items = 2 + moveOneFloor(items - 1)

moveMultiple c []     = 0
moveMultiple c (x:xs) = moveOneFloor n + (moveMultiple n xs) where n = c + x

main = do
  print ( moveMultiple 0 [8,2,0] )
  print ( moveMultiple 0 [8+4,2,0] )
