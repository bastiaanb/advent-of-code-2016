import Data.List.Split

walk = walkFrom [0, 0] [1, 0] . splitOn ", "

walkFrom pos dir = fst . foldl turnAndMove ([pos], dir)

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
  input <- getContents
  print $ distance $ last $ walk input
  print $ distance $ firstOfMultipleVisited $ walk input
  print $ distance $ firstSecondVisit [] $ walk input
