module Main where

import Data.List

-- задача 1
quickSort [] = []
quickSort (x:xs) = quickSort lesser ++ [x] ++ quickSort greater
    where
        lesser = filter (<=x) xs
        greater = filter (>x) xs

multisetSum a b = quickSort (a ++ b)

count elem lst = length (filter (==elem) lst)

concat_ ll = foldr (++) [] ll

multisetIntersect a b = concat_ [replicate (min (count x a) (count x b)) x | x <- nub(a++b)]

multisetUnion a b = concat_ [replicate (max (count x a) (count x b)) x | x <- nub(a++b)]

lstA = [1,2,2,3,3,4,5]
lstB = [2,3,3,3,5,6]

-- задача 2
-- трябва да съставим собствен comparator който да използваме в quickSort

histogram lst = [(x, count x lst) | x <- nub lst]

lst2 = ["moo", "bee", "eve", "abracadabra", "abcdefg", "mama", "z"]

-- maximumBy?
hlsort [] = []
hlsort (x:xs) = hlsort lesser ++ [x] ++ hlsort greater
    where
        lesser = filter (<=x) xs
        greater = filter (>x) xs

-- задача 3
type Quote = (String, Double)

companyCount :: String -> [Quote] -> Integer
companyCount company quotes = fromIntegral $ length [name | (name, _) <- quotes, name == company]

companyAverage :: String -> [Quote] -> Double
companyAverage company quotes = total / (fromInteger cnt)
    where total = sum [value | (name, value) <- quotes, name == company]
          cnt = companyCount company quotes

companyMax :: String -> [Quote] -> Double
companyMax company quotes = maximum [value | (name, value) <- quotes, name == company]

companyMin :: String -> [Quote] -> Double
companyMin company quotes = minimum [value | (name, value) <- quotes, name == company]

bestCompany :: [Quote] -> (String, Double, Double)
bestCompany quotes = (bestName, companyMin bestName quotes, companyMax bestName quotes)
    where (_, bestName) = maximum $ map (\name -> (companyAverage name quotes, name)) (nub $ map fst quotes)

quotes = [("Acme", 2.56), ("Buy'n'Large", 12.5), ("Acme", 42), 
    ("Smiths", 9.8), ("Buy'n'Large", 13.37), ("Acme", 10.4), ("Smiths", 10.6)]

main = do
    print(multisetUnion lstA lstB)
    print(multisetIntersect lstA lstB)
    print(multisetSum lstA lstB)

    print(histogram lst2)

    print (bestCompany quotes)