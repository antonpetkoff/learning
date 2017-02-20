module Main where
import Data.List

fac 0 = 1
fac n = n * fac (n - 1)

fib 0 = 0
fib 1 = 1
fib n = fib(n - 1) + fib(n - 2)

myPlaylist = [["janr", "pevec", "pesen"], ["chalga", "Dingo", "konq"]]

inGenre item list = (list !! 0) == item
inArtist item list = (list !! 1) == item
inSong item list = (list !! 2) == item

searchFor "genre" searchTerm playlist = [x | x <- playlist, inGenre searchTerm x]
searchFor "artist" searchTerm playlist = [x | x <- playlist, inArtist searchTerm x]
searchFor "song" searchTerm playlist = [x | x <- playlist, inSong searchTerm x]
searchFor _ searchTerm playlist = [x | x <- playlist, elem searchTerm x]

fizzBuzzReplace x
  | x == 0                              = show x
  | (rem x 3) == 0                      = "fizz"
  | (rem x 5) == 0                      = "buzz"
  | (rem x 3) == 0 && (rem x 5) == 0    = "fizzbuzz"
  | otherwise                           = show x

fizzbuzz n = map fizzBuzzReplace [0..n]


myList = ["a","c", "a", "b", "c", "b", "a"]

-- uniquify list =
    -- let uniques = nub list

f elem indeces list result
  | null list           = reverse result
  | (list !! 0) == elem = f elem (drop 1 indeces) (drop 1 list) ((list !! 0) ++ "-" ++ (show (indeces !! 0))):result
  | otherwise           = f elem indeces          (drop 1 list)  (list !! 0):result

main = do
    -- print(fizzbuzz 17)
    -- print (searchFor "genre" "chalga" myPlaylist)
    -- mapM_     print [1..10]
    -- print (nub [1,2,2,3])
    print (f "a" [0..2] myList [])