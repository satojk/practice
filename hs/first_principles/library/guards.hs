summa :: (Eq a, Num a) => a -> a
summa n = go 1 n 0
  where go cur n acc 
         | cur == n = acc + n
         | otherwise = go (cur + 1) n (acc + cur)

summa' :: (Eq a, Num a) => a -> a
summa' n
  | n == 0 = 0
  | otherwise = n + summa (n-1)

mults :: (Integral a) => a -> a -> a
mults x y = go x y 0
  where go x y acc
         | x == 0 = acc
         | otherwise = go (x-1) y (acc+y)

data DividedResult = Result (Integer, Integer) | DividedByZero
  deriving Show

dividedBy :: Integer -> Integer -> DividedResult
dividedBy num denom = case (isNeg num) == (isNeg denom) of
  True -> go (abs num) (abs denom) 0
  False -> no (abs num) (abs denom) 0
  where isNeg x = if x < 0 then True else False 
        go n   d count
         | d == 0 = DividedByZero
         | n < d = Result (count, n)
         | otherwise = go (n-d) d (count+1)
        no n   d count
         | d == 0 = DividedByZero
         | n < d = Result (count, n*(-1))
         | otherwise = no (n-d) d (count-1)

mc :: (Integral a) => a -> a
mc x = case x < 101 of
  True -> 91
  False -> x - 10
