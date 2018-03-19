import Data.Char

isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf (x:xs) [] = False
isSubsequenceOf xx@(x:xs) (y:ys)
  | x == y = isSubsequenceOf xs ys
  | x /= y = isSubsequenceOf xx ys

capitalizeWords :: String -> [(String, String)]
capitalizeWords [] = []
capitalizeWords (' ':xs) = capitalizeWords xs
capitalizeWords xs = (capitalize (takeWhile (/= ' ') xs)):(capitalizeWords (dropWhile (/= ' ') xs))
  where capitalize xx@(x:xs) = (((toUpper x):xs),xx)

capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (x:xs) = (toUpper x):xs

capitalizeParagraph :: String -> String
capitalizeParagraph [] = []
capitalizeParagraph (' ':xs) = (' ':capitalizeParagraph xs)
capitalizeParagraph xx = capitalizeWord word ++ "." ++ capitalizeParagraph rest
  where word = takeWhile (/= '.') xx
        rest = drop 1 $ dropWhile (/= '.') xx

