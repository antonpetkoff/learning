module Main where

-- sumMax :: [[Int]] -> Int
-- sumMax nns = sum $ map maxFromList nns
-- sumMax nns = sum . map maxFromList -- the nns argument is passed
-- maxFromList :: Ord a => [a] -> a
-- find a function which matches Ord a => [a] -> a
sumMax nns = sum . map maximum

data Answer = Yes Int | No Int | Unknown
type Test = [Answer]
type Exam = [Test]

valueOfAnswer :: Answer -> Int -- type is in the declaration, pattern match by value
valueOfAnswer (Yes value) = value
valueOfAnswer (No value) = negate value
valueOfAnswer Unknown = 0

testScore :: Test -> Int
testScore test = sum $ map valueOfAnswer test

examScore :: Exam -> Int
examScore exam = sum $ map testScore exam

avgScore :: Exam -> Double
avgScore exam = (fromIntegral total) / (fromIntegral count)
    where
        total = examScore exam
        count = length exam

-- highestScore :: Exam -> Test
-- how to get the max of a list of Tests
-- maximumBy :: Foldable t => (a -> a -> Ordering) -> t a -> a
-- where Ordering in {-1, 0, 1}
-- you could sort (sortBy) and get an Ordering

-- return the function which gives the maximum value
-- you could return a lambda (\x->...) or a name accompanied by a where definition
maxFunction :: Ord a => [(a -> a)] -> (a -> a)
maxFunction fs = (\x -> maximum (map (\f -> f x) fs))
-- maxFunction fs x = maximum $ map (\f -> f x) fs

-- recursive algebric types
data Tree a = Empty | Node a (Tree a) (Tree a) deriving Show -- Tree a is a template type where a is the type
-- use pattern matching for classifying value constructors
-- the pattern matching is by the value constructors! not by the type
myTree = Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)

countNodes :: Tree a -> Int
countNodes Empty = 0
countNodes (Node _ left right) = 1 + countNodes left + countNodes right

treeHeight :: Tree a -> Int
treeHeight Empty = 0
treeHeight (Node _ left right) = 1 + max (treeHeight left) (treeHeight right)

flattenTree :: Tree a -> [a]
flattenTree Empty = []
flattenTree (Node value left right) = (flattenTree left) ++ [value] ++ (flattenTree right)

treeFind :: Ord a => a -> Tree a -> Bool
treeFind elem Empty = False
treeFind elem (Node value left right)
    | value == elem = True
    | otherwise     = (treeFind elem left) || (treeFind elem right)

bstInsert :: Ord a => a -> Tree a -> Tree a
bstInsert elem Empty = (Node elem Empty Empty)
bstInsert elem (Node value left right)
    | elem <= value = (Node value (bstInsert elem left) right)
    | otherwise     = (Node value left (bstInsert elem right))

main = do
    -- print (sumMax [[1,2,3],[4]])
    print (valueOfAnswer Unknown)
    print (valueOfAnswer (Yes 3))
    print (valueOfAnswer (No 2))
    print (testScore [(Yes 3), (Yes 2)])
    print (examScore [[(Yes 3), (Yes 2)], [(Yes 3), (Yes 2)], [(Yes 3), (Yes 2)]])
    print (avgScore [[(Yes 3), (Yes 2)], [(Yes 3), (Yes 2)], [(Yes 3), (Yes 2)]])
    print ( (maxFunction [(\x -> x * x), (\x -> x * x * x)]) 3  )
    print (countNodes myTree)
    print (treeHeight myTree)
    print (flattenTree myTree)
    print (treeFind 3 myTree)
    print (bstInsert 1 myTree)