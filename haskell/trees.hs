module Main where

data Tree a = Empty | Node a (Tree a) (Tree a) deriving Show

myTree = Node 5 (Node 3 Empty Empty) (Node 8 Empty Empty)

leftTree :: Tree a -> Tree a
leftTree Empty = Empty
leftTree (Node value left _) = left

rightTree :: Tree a -> Tree a
rightTree Empty = Empty
rightTree (Node value _ right) = right

treeValue :: Tree a -> a
treeValue (Node value _ _) = value
treeValue Empty = error "no value"

flattenTree :: Tree a -> [a]
flattenTree Empty = []
flattenTree (Node value left right) = (flattenTree left) ++ [value] ++ (flattenTree right)

countNodes :: Tree a -> Int
countNodes Empty = 0
countNodes (Node _ left right) = 1 + (countNodes left) + (countNodes right) 

treeHeight :: Tree a -> Int
treeHeight Empty = 0
treeHeight (Node _ left right) = 1 + max (treeHeight left) (treeHeight right)

bstInsert :: Ord a => a -> Tree a -> Tree a
bstInsert elem Empty = (Node elem Empty Empty)
bstInsert elem (Node value left right)
    | elem <= value = (Node value (bstInsert elem left) right)
    | otherwise     = (Node value left (bstInsert elem right))

isEmpty :: Tree a -> Bool
isEmpty Empty = True
isEmpty _ = False

isLeaf :: Tree a -> Bool
isLeaf Empty = False
isLeaf (Node _ left right) = (isEmpty left) && (isEmpty right)

boolToInt :: Bool -> Int
boolToInt True = 1
boolToInt False = 0

countLeaves :: Tree a -> Int
countLeaves Empty = 0
countLeaves node@(Node _ left right) = 
    if isLeaf node then 1
    else (countLeaves left) + (countLeaves right)

orTree :: Tree a -> Tree a -> Tree a
orTree x Empty = x
orTree Empty x = x
orTree _ _ = Empty

treeFind :: Ord a => a -> Tree a -> Tree a
treeFind elem Empty = Empty
treeFind elem node@(Node value left right)
    | value == elem = node
    | otherwise     = orTree (treeFind elem left) (treeFind elem right)

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f Empty = Empty
treeMap f (Node x l r) = (Node (f x) (treeMap f l) (treeMap f r))

main = do
    print (leftTree myTree)
    print ((rightTree Empty) :: Tree Int)
    print (treeValue myTree)
    print (flattenTree myTree)
    print (countNodes myTree)
    print (treeHeight myTree)
    print (bstInsert 4 myTree)
    print (isEmpty myTree)
    print (countLeaves myTree)
    print (treeFind 3 myTree)
    print (treeFind 3 (bstInsert 3 myTree))
    print (treeMap (\x -> x * x) myTree)