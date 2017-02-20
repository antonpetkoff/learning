module Main where

-- zad 1
listToFunction :: [Int] -> (Int -> Int)
listToFunction lst = (\x -> if elem x lst then x else 0)

f = listToFunction [1,2,3]

-- zad 2
listToPredicate :: [(Int, Int)] -> (Int -> Int -> Bool)
listToPredicate lst = (\a b -> if elem (a, b) lst then True else False)

p = listToPredicate [(1,2),(2,3),(3,8)]

-- zad 3

main = do
    print (f 1)
    print (f (-2))
    print (p 1 2)
    print (p 2 5)