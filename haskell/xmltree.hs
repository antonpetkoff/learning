module Main where

import System.IO
import Text.Regex.Posix
import Data.List.Split

-- TODO: don't parse HTML with regex

data Attribute = Attribute {name :: String, value :: String} deriving (Show, Eq)
data Tree = Tree {tag :: String, children :: [Tree], attributes :: [Attribute]}
          | Leaf {tag :: String, text :: String, attributes :: [Attribute]} deriving Show
-- if Leaf has no text, it is a self-closing tag
-- assert :: Tree always has at least 1 child

attr1 = Attribute "src" "madonna.jpg"
attr2 = Attribute "encoding" "UTF8"
attr3 = Attribute "encoding" "Windows1251"

leaf1 = Leaf "img" "" [attr1, attr2]
leaf2 = Leaf "p" "myParagraph" [attr2]
leaf3 = Leaf "p" "myParagraph2" [attr2]
leaf4 = Leaf "img" "" [attr1, attr3]

tree1 = Tree "div" [leaf1, leaf2, leaf3, leaf4] []

showAttributes :: [Attribute] -> String
showAttributes [] = ""
showAttributes attributes = concat [" " ++ name attr ++ "=\"" ++ value attr ++ "\"" | attr <- attributes]

showLeaf :: Tree -> String
showLeaf (Leaf tag text attributes)
    | text == ""    = concat ["<", tag, showAttributes attributes, "/>"]
    | otherwise     = concat ["<", tag, showAttributes attributes, ">", text, "</", tag, ">"]

tabs :: Int -> String
tabs n = concat $ replicate n "\t"

showTree :: Int -> Tree -> String
showTree level leaf@(Leaf _ _ _) = concat [tabs level, showLeaf leaf]
showTree level (Tree tag children attributes) = concat [openingTag, content, closingTag]
    where
        openingTag = concat [tabs level, "<", tag, showAttributes attributes, ">\n"]
        content = unlines $ map (showTree (level + 1)) children
        closingTag = concat ["</", tag, ">"]

-- mapChildren :: list of children -> XPath selector -> function -> list of children
-- mapChildren :: [Tree] -> String -> (Tree -> Tree) -> [Tree]

-- create :: Tree -> [String] -> Tree
-- create tree [] = tree
-- create tree@(Tree tag children attributes) selectors@(head:tail) =
    -- (Tree tag (mapChildren children head (\t -> create t tail)) attributes)

decomposePath :: String -> [String]
decomposePath path = splitOn "/" path

getTagFromPath :: String -> String
getTagFromPath path = if null match then "" else match !! 0 !! 1
    where match = (path =~ "^([A-Za-z]+).*") :: [[String]]

-- TODO: somehow the regex doesn't match dashes
getAttributeFromPath :: String -> Attribute
getAttributeFromPath path =
    if null match then (Attribute "" "")
    else (Attribute name value)
    where match = (path =~ "^[A-Za-z]+\\(([A-Za-z]+)=\"([A-Za-z0-9 \\!\\@\\.\\-\\_\\{\\}]+)\"\\).*") :: [[String]]
          name = if null match then "" else match !! 0 !! 1
          value = if null match then "" else match !! 0 !! 2

getIndexFromPath :: String -> Int
getIndexFromPath path = if null match then (-1) else (read (match !! 0 !! 1) :: Int)
    where match = (path =~ ".*\\[([0-9]+)\\].*") :: [[String]]

getAttrValueFromPath :: String -> String
getAttrValueFromPath path = if null match then "" else match !! 0 !! 1
    where match = (path =~ ".*\\@(.*)") :: [[String]]

readTree :: Tree -> [String] -> Tree
readTree root [selector] = filterTree root selector
readTree root selectors@(headSel:tailSel) = readTree (filterTree root headSel) tailSel

tagEquals :: String -> Tree -> Bool
tagEquals str tree = str == (tag tree)

attributeEquals :: Attribute -> Tree -> Bool
attributeEquals attr tree = attr `elem` (attributes tree)

-- TODO: type Selector = String
filterTree :: Tree -> String -> Tree
filterTree tree@(Tree tag children attributes) selector = filteredByIndex
    where
        pathTag = getTagFromPath selector
        pathAttribute = getAttributeFromPath selector
        pathIndex = getIndexFromPath selector
        filteredByTag = filter (tagEquals pathTag) children
        filteredByAttribute = if (Attribute "" "") == pathAttribute then filteredByTag
            else filter (attributeEquals pathAttribute) filteredByTag
        filteredByIndex = if (-1) == pathIndex || pathIndex >= length filteredByAttribute then filteredByAttribute !! 0
            else filteredByAttribute !! pathIndex

main = do
    writeFile "output.xml" (showTree 0 tree1)

    print (showLeaf $ readTree tree1 (decomposePath "img(src=\"madonna.jpg\")[1]"))
