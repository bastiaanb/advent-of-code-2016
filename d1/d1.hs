input = ["R4", "R4", "L1", "R3", "L5", "R2", "R5", "R1", "L4", "R3", "L5", "R2", "L3", "L4", "L3", "R1", "R5", "R1", "L3", "L1", "R3", "L1", "R2", "R2", "L2", "R5", "L3", "L4", "R4", "R4", "R2", "L4", "L1", "R5", "L1", "L4", "R4", "L1", "R1", "L2", "R5", "L2", "L3", "R2", "R1", "L194", "R2", "L4", "R49", "R1", "R3", "L5", "L4", "L1", "R4", "R2", "R1", "L5", "R3", "L5", "L4", "R4", "R4", "L2", "L3", "R78", "L5", "R4", "R191", "R4", "R3", "R1", "L2", "R1", "R3", "L1", "R3", "R4", "R2", "L2", "R1", "R4", "L5", "R2", "L2", "L4", "L2", "R1", "R2", "L3", "R5", "R2", "L3", "L3", "R3", "L1", "L1", "R5", "L4", "L4", "L2", "R5", "R1", "R4", "L3", "L5", "L4", "R5", "L4", "R5", "R4", "L3", "L2", "L5", "R4", "R3", "L3", "R1", "L5", "R5", "R1", "L3", "R2", "L5", "R5", "L3", "R1", "R4", "L5", "R4", "R2", "R3", "L4", "L5", "R3", "R4", "L5", "L5", "R4", "L4", "L4", "R1", "R5", "R3", "L1", "L4", "L3", "L4", "R1", "L5", "L1", "R2", "R2", "R4", "R4", "L5", "R4", "R1", "L1", "L1", "L3", "L5", "L2", "R4", "L3", "L5", "L4", "L1", "R3"]
startPos = [0, 0]
startDir = [1, 0]

walk = fst $ foldl turnAndMove ([startPos], startDir) input

turnAndMove (path, dir) (turn:steps) = (newPath, newDir)
  where
    newDir = rotate turn dir
    newPath = path ++ ( take (read steps :: Int) $ tail $ iterate (move newDir) $ last path )

move = zipWith (+)

rotate 'L' [x, y] = [y, -x]
rotate 'R' [x, y] = [-y, x]

distance = sum . map abs

-- both crash if there is no location with multiple visits :-)
firstOfMultipleVisited (x:xs) = if x `elem` xs then x else firstOfMultipleVisited xs
firstSecondVisit h (x:xs) = if x `elem` h then x else firstSecondVisit (h ++ [x]) xs

main = do
  print $ distance $ last $ walk
  print $ distance $ firstOfMultipleVisited $ walk
  print $ distance $ firstSecondVisit [] $ walk
