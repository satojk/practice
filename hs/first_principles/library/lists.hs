myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = if x == False then False else myAnd xs

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = if x == True then True else myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny f xs = myOr lis
  where lis = map f xs

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem y (x:xs) = (y == x || myElem y xs)

myElem' :: Eq a => a -> [a] -> Bool
myElem' y xs = any (y == ) xs

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

squish :: [[a]] -> [a]
squish [] = []
squish (x:xs) = (x ++ (squish xs))

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f xs = foldr (++) [] (map f xs)

squishMap' :: (a -> [b]) -> [a] -> [b]
squishMap' _ [] = []
squishMap' f (x:xs) = (f x) ++ (squishMap' f xs)

squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ (x:[]) = x
myMaximumBy f (x:xs) = g x (myMaximumBy f xs)
  where g a b = case f a b of
                LT -> b
                GT -> a
                EQ -> a

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ (x:[]) = x
myMinimumBy f (x:xs) = g x (myMinimumBy f xs)
  where g a b = case f a b of
                LT -> a
                GT -> b
                EQ -> a

myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare
