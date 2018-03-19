import Data.Time

data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate   UTCTime
                  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
  [ DbDate (UTCTime
            (fromGregorian 1911 5 1)
    (secondsToDiffTime 34123))
  , DbNumber 9001
  , DbString "Hello, world!"
  , DbDate (UTCTime
            (fromGregorian 1921 5 1)
            (secondsToDiffTime 34123))
  ]

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate = foldr f []
  where f (DbDate (a)) = (++) [a]
        f _ = (++) []

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber = foldr f []
  where f (DbNumber a) = (++) [a]
        f _ = (++) []

mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = maxli.filterDbDate
  where maxli (x:[]) = x
        maxli (x:xs) = max x (maxli xs)

sumDb :: [DatabaseItem] -> Integer
sumDb = sum.filterDbNumber

avgDb :: [DatabaseItem] -> Double
avgDb = myAv.filterDbNumber
  where myAv xs = (fromIntegral (sum xs))/(fromIntegral $ length xs)
