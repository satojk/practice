notThe :: String -> Maybe String
notThe x = case x == "the" of
  True -> Nothing
  False -> Just x

replaceThe :: String -> String
replaceThe [] = []
replaceThe (' ':xx) = (' ':(replaceThe xx))
replaceThe xx = go (takeWhile (/= ' ') xx) ++ replaceThe (dropWhile (/= ' ') xx)
  where go x = case notThe x of
          Nothing -> "a"
          Just x  -> x

