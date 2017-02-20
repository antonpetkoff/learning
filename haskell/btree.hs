module Main where

graph = [(1, [2]), (2, [3, 4]), (3, [4]), (4, [])]

add_vertex v g = 
    if length [x | x <- g, fst x == v] > 0 
        then g
    else (v, []) : g

add_edge x y g =
    let sublist = [snd x | x <- g, fst x == v]

    if length sublist > 0
        then list = sublist !! 0
        if y `elem` list
            then g
        else [if fst v == x then (x, y:(snd v)) else v | v <- g]
    else
        add_edge x y (add_vertex x g)

main = do
    print (add_vertex 6 graph)