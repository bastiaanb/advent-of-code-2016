{-# LANGUAGE OverloadedStrings #-}

import Crypto.Hash.MD5 as MD5
import Data.ByteString.Base16
import qualified Data.ByteString.Char8 as C8

fiveZerosHash = filter (C8.isPrefixOf "00000") $ map (encode.(MD5.hash).(C8.pack).("reyedfim" ++).show) [0..]

main = print $ map (\x -> C8.index x 5) $ take 8 $ fiveZerosHash
