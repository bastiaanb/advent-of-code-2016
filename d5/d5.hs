import Data.Char
import Data.List
import Data.Maybe
import Data.ByteString.Base16
import qualified Data.ByteString.Char8 as C8
import Crypto.Hash.MD5 as MD5

fiveZerosHashes = map C8.unpack $ filter (C8.isPrefixOf $ C8.pack "00000") $ map (encode.MD5.hash.C8.pack.("reyedfim" ++).show) [0..]

findDigits state (x:xs) =
  let i = digitToInt $ x !! 5
  in
    if i < length state && isNothing (state !! i) then
      let newState = (take i state) ++ [Just $ x !! 6] ++ (drop (i + 1) state)
        in
          if all isJust newState then
            map fromJust newState
          else
            findDigits newState xs
    else
      findDigits state xs

main = do
    print $ map (\x -> x !! 5) $ take 8 $ fiveZerosHashes
    print $ findDigits (replicate 8 Nothing) fiveZerosHashes
