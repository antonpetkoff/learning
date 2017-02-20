import Prelude hiding (not)

data PRF = Z | S | I Int Int | C PRF [PRF] | R PRF PRF

instance Show PRF where
    show Z = "Z"
    show S = "S"
    show (I n i) = "I " ++ (show n) ++ " " ++ (show i)
    show (C f gs) = "C " ++ (parenShow f) ++ " " ++ (show gs)
    show (R f g) = "R " ++ (parenShow f) ++ " " ++ (parenShow g)
    showList [] = showString "[]"
    showList xs = (showString "[") . (sl xs) where
        sl [x] = (shows x) . (showString "]")
        sl (x:xs) = (shows x) . (showString ", ") . (sl xs)

parenShow :: PRF -> [Char]
parenShow Z = "Z"
parenShow S = "S"
parenShow f = "(" ++ (show f) ++ ")"

eval :: PRF -> [Int] -> Int
eval _ [] = error "No arguments"
eval Z [x] = 0
eval S [x] = x + 1
eval (I n i) xs = xs !! i
eval (C f gs) xs = eval f (map (\g -> eval g xs) gs)
eval (R f _) (0:xs) = eval f xs
eval (R f g) (y:xs) = eval g ((eval (R f g) (y-1:xs)):y-1:xs)
eval _ _ = error "Incorrect call"

not :: PRF
not = Z

plus :: PRF
plus = R (I 1 0) (C S [I 3 0])

mult :: PRF
mult = R Z (C plus [(I 3 0), (I 3 2)])

star :: PRF -> PRF
star f = R (I 3 0) (C f [I 3 0])

constant :: PRF
constant = star S

power :: PRF
--                      TODO: swap the projections and monitor performance
power = R (C S [Z]) (C mult [(I 3 2), (I 3 0)])

main = do
    print $ eval plus [10, 15]
    print $ eval mult [2, 5]
    print $ eval constant [0, 42]
    print $ eval power [12, 2]
