module Lists where
import System.Random
import Control.Monad (replicateM)
import Data.List

-- 1 Find the last element of a list
myLast :: [a] -> a
myLast [] = error "Empty list"
myLast (x:[]) = x
myLast (x:xs) = myLast xs

-- 2 Find the last but one element of a list
myButLast :: [a] -> a
myButLast [] = error "Empty list"
myButLast (x:[]) = error "Short list!"
myButLast (x1:x2:[]) = x1
myButLast (x1:x2:xs) = myButLast (x2:xs)

-- 3 Find the kth element in the list. First element is number 1
elementAt :: (Integral b) => [a] -> b -> a
elementAt [] _ = error "Empty list"
elementAt (x:xs) ind =
  if ind == 1
    then x
    else elementAt xs (ind-1)

-- 4 Find the number of elements in a list
myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = myLength xs + 1

-- 5 Reverse a list
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- 6 Find out whether a list is a palindrome
isPal :: (Eq a) => [a] -> Bool
isPal a = a == myReverse a

-- 7 Flatten a nested list structure
data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (List []) = []
flatten (Elem x) = [x]
flatten (List (x:xs)) = (flatten x) ++ (flatten (List xs))

-- 8 Eliminate consecutive duplicates of a list of elements
compress :: (Eq a) => [a] -> [a]
compress [] = []
compress (x:[]) = [x]
compress (x:xs) = go x xs
  where
    go x yy@(y:_) =
      if x == y
        then compress yy
        else x:(compress yy)

-- 9 Pack consecutive duplicates of a list into sublists
pack :: (Eq a) => [a] -> [[a]]
pack [] = []
pack xx@(x:xs) =
  (fst part):(pack $ snd part)
    where
      part = span (==x) xx

-- 10 Run-length encode a list
rle :: (Eq a) => [a] -> [(Int, a)]
rle xx = go.pack $ xx
  where
    go :: (Eq a) => [[a]] -> [(Int, a)]
    go [] = []
    go (x:xs) = (length x, x !! 0):(go xs)

-- 11 Same as above, but in case an element has no dups, it simply gets copied to the list
data Encode a = Singleton a | Encoded (Int, a)
instance (Show a) => Show (Encode a) where
  show (Singleton a) = show a
  show (Encoded (b, a)) = show (b, a)

rleMod :: (Eq a) => [a] -> [Encode a]
rleMod xx = go.pack $ xx
  where
    go :: (Eq a) => [[a]] -> [Encode a]
    go [] = []
    go (x:xs) =
      if length x > 1
        then (Encoded (length x, x !! 0)):(go xs)
        else (Singleton (x !! 0)):(go xs)

-- 12 Decode a list RLE'd by 11
decodeMod :: (Eq a) => [Encode a] -> [a]
decodeMod [] = []
decodeMod (x:xs) = (decodeUnit x) ++ (decodeMod xs)
  where
    decodeUnit :: Encode a -> [a]
    decodeUnit (Singleton x) = [x]
    decodeUnit (Encoded (n, x)) = take n $ repeat x

-- 13 Same as 11 but without using `pack`
rleDirect :: (Eq a) => [a] -> [Encode a]
rleDirect [] = []
rleDirect (x:xs) = go 1 x xs
  where
    go n a [] =
      if n == 1
        then [Singleton a]
        else [Encoded (n, a)]
    go n a (b:bs) =
      if a == b
        then go (n+1) a bs
        else if n == 1
          then (Singleton a):(go 1 b bs)
          else (Encoded (n, a)):(go 1 b bs)

-- 14 Duplicate the elements of a list
dupli :: [a] -> [a]
dupli [] = []
dupli (x:xs) = (x:x:(dupli xs))

-- 15 N-plicate the elements of a list
npli :: [a] -> Int -> [a]
npli [] _ = []
npli (x:xs) n = concat [take n (repeat x), npli xs n]

-- 16 Drop every N'th element from a list
dropEvery :: [a] -> Int -> [a]
dropEvery [] _ = []
dropEvery xx n = go xx (n-1) (n-1)
  where
    go [] _ _ = []
    go (x:xs) n m =
      if n == 0
        then go xs m m
        else x:(go xs (n-1) m)

-- 17 Split a list at the N'th position
mySplitAt :: [a] -> Int -> ([a], [a])
mySplitAt xx n = (go1 xx (n-1), go2 xx (n-1))
  where
    go1 [] _ = []
    go1 (x:xs) n =
      if n == 0
        then [x]
        else x:(go1 xs (n-1))
    go2 (x:xs) n =
      if n == 0
        then xs
        else go2 xs (n-1)

-- 18 Extract from the i'th to the k'th element of a list
mySlice :: [a] -> Int -> Int -> [a]
mySlice [] _ _ = []
mySlice (x:xs) i k
  | k == 0 = []
  | i == 1 = x:(mySlice xs 1 (k-1))
  | otherwise = mySlice xs (i-1) (k-1)

-- 19 Rotate a list N places to the left
myRotate :: [a] -> Int -> [a]
myRotate xx n = (snd part) ++ (fst part)
  where
    part = mySplitAt xx n

-- 20 Remove the K'th element of a list
myPop :: [a] -> Int -> (a, [a])
myPop [] _ = error "Empty list!"
myPop xx n = (popped xx n, without xx n)
  where
    popped (x:xs) n =
      if n == 1
        then x
        else popped xs (n-1)
    without (x:xs) n =
      if n == 1
        then xs
        else x:(without xs (n-1))

-- 21 Insert an element at a given position in a list
insertAt :: a -> [a] -> Int -> [a]
insertAt _ [] _ = error "Empty list!"
insertAt e (x:xs) n =
  if n == 1
    then (e:x:xs)
    else (x:(insertAt e xs (n-1)))

-- 22 Create a list containing all integers in a given range
myRange :: Int -> Int -> [Int]
myRange b e
  | b == e = [e]
  | otherwise = b:(myRange (b+1) e)

-- 23 Extract N random elements from a list
rndExtract :: [a] -> Int -> IO [a]
rndExtract [] _ = return []
rndExtract l n
  | n < 0 = error "Can't extract a negative quantity"
  | otherwise = do
    pos <- replicateM n $
           getStdRandom $
           randomR (0, (length l)-1)
    return [l !! p | p <- pos]

-- 23.b Pops N random elements from a list
    
-- 26 Generate all combinations of N distinct objects from a list
combs :: Int -> [a] -> [[a]]
combs _ [] = []
combs n xx = concat.(fmap (go n)) $ (tails xx)
  where
    go _ [] = []
    go n xx@(x:xs)
      | n == 1 = [[y] | y <- xx]
      | otherwise = [(x:yy) | yy <- (go (n-1) xs)]

-- 27 Group the elements of a set into disjoint subsets

-- 28 Sort a list of lists according to the length of the sublists
lengthSort :: [[a]] -> [[a]]
lengthSort [] = []
lengthSort (x:xs) =
  lengthSort [y | y <- xs, (length y) <= (length x)] ++
  [x] ++
  lengthSort [y | y <- xs, (length y) > (length x)]

-- 28.b Sort a list of lists according to the length frequency of the sublists
lengthfSort :: [[a]] -> [[a]]
lengthfSort [] = []
lengthfSort xx@(x:xs) = go xx (x:xs)
  where
    go _ [] = []
    go xx (x:xs) =
      go xx [y | y <- xs, (lf y) <= (lf x)] ++
      [x] ++
      go xx [y | y <- xs, (lf y) > (lf x)]
    lf n = length [z | z <- xx, length z == length n]

