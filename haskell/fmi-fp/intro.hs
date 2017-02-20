import Prelude hiding (elem, (++), (!!))

quickSort [] = []
quickSort (x:xs) = quickSort less ++ [x] ++ quickSort more
  where less = filter (<=x) xs
        more = filter (>x) xs

factorial x = if x > 1 then x * factorial(x - 1) else 1

l = [1, 2, 3]

myMap f l = [f x | x <- l]  -- list comprehension
myFilter p l = [x | x <- l, p x]
triple = (1, "Pesho", 3.14)
(a,b,c) = triple

mat = [[1,2,3],[4,5,6],[7,8,9],[10,11,12],[13,14,15],[16,17,18]]

zad1 ll x i = elem x (ll !! (quot i 3))

fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- l1 ++ l2 = if null l1 then l2 else head l1 : tail l1 ++ l2

[] ++ l2 = l2
(x:xs) ++ l2 = x:xs ++ l2

-- l !! n
--  | n == 0    = head l
--  | otherwise = tail l !! (n - 1)

(!!) :: [a] -> Int -> a
(x:_) !! 0 = x
(_:xs) !! n = xs !! (n - 1)


len [] = 0
len l = len (tail l) + 1

-- elem x l
--  | null l       = False
--  | head l == x  = True
--  | otherwise    = elem x (tail l)

elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem x (y:ys) = x == y || elem x ys

type Int3 = [(Int, Int, Int)]
pythagoreanTriple :: Int -> Int3
pythagoreanTriple n = 
    [(x,y,z) | x <- [1..n], y <- [1..x-1], z <- [max x y..n], x^2 + y^2 == z^2]

main = do
        -- print (factorial 5)
        -- print (l !! 0)
        -- print (myMap (*2) [1..10])
        -- print ([x * 2 | x <- [0..10000], x `mod` 85 == 23]) -- remember the ``
        -- print (myFilter odd [1..10])
        -- print (zad1 mat 15 15)
        -- print (take 10 fibs)
        -- print ([1] ++ [2, 3])
        -- print ([1,2,3] !! 2)
        -- print (elem 4 [1..5])
        -- print (len [1..5])
        print (pythagoreanTriple 20)