moveOneFloor 1     = 1
moveOneFloor 2     = 1
moveOneFloor items = 2 + moveOneFloor(items - 1)

moveMultipleFloors [x]    = moveOneFloor x
moveMultipleFloors (x:xs) = moveOneFloor x + (moveMultipleFloors ((x + (head xs)):(tail xs)))

main = do
  print ( moveMultipleFloors [8,2,0] )
  print ( moveMultipleFloors [8+4,2,0] )
