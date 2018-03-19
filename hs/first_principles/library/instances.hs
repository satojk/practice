-- Write the Eq instance for the datatype provided

data TisAnInteger = 
    TisAn Integer

instance Eq TisAnInteger where
    (==) (TisAn a) (TisAn b) = a == b


data TwoIntegers = 
    Two Integer Integer

instance Eq TwoIntegers where
    (==) (Two a b) (Two c d) = a == c && b == d

data StringOrInt =
    TisAnInt   Int
  | TisAString String

instance Eq StringOrInt where
    (==) (TisAnInt a) (TisAnInt b) =
        a == b
    (==) (TisAString a) (TisAString b) =
        a == b
    (==) _ _ = False

data Pair a =
    Pair a a

instance Eq a => Eq (Pair a) where 
    (==) (Pair a b) (Pair c d) = a == b && c == d

data Tuple a b =
    Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
    (==) (Tuple a b) (Tuple c d) = a == c && b == d

data Which a =
    ThisOne a
  | ThatOne a

instance (Eq a) => Eq (Which a) where
    (==) (ThisOne x) (ThisOne y) = x == y
    (==) (ThatOne x) (ThatOne y) = x == y
    (==) _ _ = False

data EitherOr a b =
    Hello a
  | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
    (==) (Hello x) (Hello y) = x == y
    (==) (Goodbye x) (Goodbye y) = x == y
    (==) _ _ = False
