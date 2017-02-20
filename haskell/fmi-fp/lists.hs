module Main where
import Prelude hiding (init, last, take, drop, sum, map, filter, scanr)

replicate' times val = take times [val,val..]

take' n list = drop ((length list) - n) list

init :: [a] -> [a]
init [x] = []
init (x:xs) = x:init xs

last :: [a] -> a
last [x] = x
last (_:xs) = last xs

take :: Int -> [a] -> [a]
take 0 _ = []
take n (x:xs)
  | n < 0 = error "Отрицателно число!"
  | otherwise = x:take (n-1) xs

drop :: Int -> [a] -> [a]
drop 0 l = l
drop n (x:xs)
  | n < 0 = error "Отрицателно число!"
  | otherwise = drop (n-1) xs

map f = foldr (\x -> (f x:)) []
filter p = foldr (\x -> if p x then (x:) else id) []

scanr :: (a -> b -> b) -> b -> [a] -> [b]
scanr _ nv [] = [nv]
scanr op nv (x:xs) = x `op` r : rest
  where rest@(r:_) = scanr op nv xs

main = do
    -- print (init [1..5])
    -- print (last [1..5])
    -- print (drop 2 [1..5])
    -- print (take 2 [1..5])
    -- print (replicate' 5 10)
    -- print (take' 5 [1..10])
    print (concat (map (\x -> map (\y -> (x, y)) [5..7]) [1..3]))
    print (filter odd [1..10])
    print (scanr (+) 0 [1..10])