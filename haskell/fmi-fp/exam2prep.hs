module Main where
import Data.List

count :: Eq a => a -> [a] -> Int
count x lst = length(filter (x==) lst)

remove :: Eq a => a -> [a] -> [a]
remove x lst = filter (x/=) lst

histogram :: Eq a => [a] => [(a,Int)]
histogram lst = map (\x -> (x, count x lst)) (nub lst)

maxRepeated :: Eq a => [a] -> Int
maxRepeated lst = maximum $ map length (group lst)

type Point = (Double, Double)
maxDistance :: [Point] -> (Point -> Point -> Double) -> Double
maxDistance lst dist = maximum [dist x y | x <- lst, y <- lst, x /= y]

dist :: Point -> Point -> Double
dist (x1, y1) (x2, y2) = sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))

a :: Point
a = (0,0)
b :: Point
b = (1,1)



data Tree = Empty | Node Int Tree Tree deriving Show

maxSumPath :: Tree -> Int
maxSumPath Empty = 0
maxSumPath (Node x l r) = x + (max (maxSumPath l) (maxSumPath r))

main = do
    print(count 2 [1,2,2,3,4,2])
    print(remove 2 [1,2,2,3,4,2])
    print(histogram [1,2,3,3,2,1,4,5,2])
    print(maxRepeated [1,1,2,2,2,2,3,2,1,1,1,2])
    print(dist a b)
    print(maxDistance [(-1.1, 1), (1.8, 2), (3, 1), (-1, -2)] dist)
    print(maxSumPath (Node 2 (Node 10 Empty Empty) (Node 0 Empty Empty)))