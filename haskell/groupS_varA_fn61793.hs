module Main where
import Data.List

-- task 1
findColumns :: [[Int]] -> Int
findColumns mat = length $ filter (\col -> listEqualsSomeRow col mat) (transpose mat)  -- for each column

-- all elements of lst are contained in some row of the matrix mat
listEqualsSomeRow :: [Int] -> [[Int]] -> Bool
listEqualsSomeRow lst mat = not $ null $ filter (\row -> containsAll lst row) mat

-- all elements in a are contained in b
containsAll :: [Int] -> [Int] -> Bool
containsAll a b = a == (filter (\x -> elem x b) a)

mat = [[1, 4, 3],[4, 5, 6], [7, 4, 9]]

-- task 2
combine f g h = (\x -> h (f x) (g x))

-- combine all unary functions from uns with the given binary function bin
combineAll uns bin = [combine f g bin | f <- uns, g <- uns]

-- generate all function combinations
generateAllCombines uns bins = concat $ map (combineAll uns) bins

-- is f equal to g over interval [a, b]
fEq f g a b = null $ filter (==False) [(f x) == (g x) | x <- [a..b]]

-- does the given f equal to any of the given unary functions over interval [a, b]
fEqAnyUnary f uns a b = not $ null $ filter (==True) (map (\unary -> fEq unary f a b) uns)

-- forAll combinations check if the combination is equal to some unary function over interval [a, b]
check a b uns bins = not $ null $ filter (==True) (map (\f -> fEqAnyUnary f uns a b) (generateAllCombines uns bins))

uns = [(+1), (\x -> x - 1), (\x -> x - 1).(^2)]
bins = [(*)]

-- task 3
type Plant = (String, Int, Int)

plants = [("peas", 5, 25), ("beans", 3, 15), ("cocoa", 20, 30)]

quickSortComp comp [] = []
quickSortComp comp (x:xs) =
        quickSortComp comp [y | y <- xs, comp y x]
    ++  [x]
    ++  quickSortComp comp [y | y <- xs, comp x y]                    

-- sorts by |min-max| descending
plantCompareLength (_, min1, max1) (_, min2, max2) = (max1 - min1) > (max2 - min2)

-- sorts by min field ascending
plantCompareStart (_, min1, _) (_, min2, _) = min1 < min2

plantSort plants = quickSortComp plantCompareStart plants

-- for a given list of plants and an interval [a, b] return a list of all plant names overlapping the interval
iterateInterval a b [] = []
iterateInterval a b (h@(name, low, high):t)
    | intervalsOverlap a b low high     = [name] ++ (iterateInterval (max a low) (min b high) t)    -- narrow down the interval
    | otherwise                         = []

-- TODO: no time left :(
intervalsOverlap a b x y = 
        a <= x && b >= y
    ||  x <= a && b >= a

-- garden :: [Plant] -> [String]
-- for each list which (tails (plantSort plants) gives us find the sequence of overlapping intervals
-- finally return the largest of these squences
-- отивам на ДАА
-- garden plants = map (iterateInterval) (tails (plantSort plants))

main = do
    -- print (containsAll [4, 5] [4, 5, 6])
    -- print (transpose mat)
    -- print (listEqualsSomeRow [4, 5, 4] mat)
    print (findColumns mat)

    -- print (fEq (+1) (\x -> x - 1) 1 9)
    -- print (fEqAnyUnary (+1) uns 1 9)
    print (check 1 9 uns bins)

    -- print (quickSortComp (>) [1, 7, 5, 9, 3])
    -- print (plantSort plants)
    -- print (intervalsOverlap 5 13 15 25)
    -- print (garden plants)