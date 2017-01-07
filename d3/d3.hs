import Data.Char
import Data.List
import Data.List.Split

isTriangle [a, b, c] = a + b > c && a + c > b && b + c > a

countTriangles = length . filter isTriangle

transpose3 = concat . map transpose . chunksOf 3

main = do
  contents <- getContents
  let
    input = map (map (read :: String -> Int) . words) $ lines contents
  print $ countTriangles input
  print $ countTriangles $ transpose3 input
