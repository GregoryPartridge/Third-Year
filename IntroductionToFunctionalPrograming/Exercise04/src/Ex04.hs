{- butrfeld Andrew Butterfield -}
module Ex04 where

name, idno, username :: String
name      =  "Gregory Partridge"  -- replace with your name
idno      =  "17331009"    -- replace with your student id
username  =  "partridg"   -- replace with your TCD username

declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype, honestly!
data BinTree k d
  = Branch (BinTree k d) (BinTree k d) k d
  | Leaf k d
  | Empty
  deriving (Eq, Show)

-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> BinTree k d -> BinTree k d
-- Insert into empty
ins k d Empty = Leaf k d
-- Insert into leaf, if same change value, if not add branch with new leaf
ins x y (Leaf a b) 
  | x==a = Leaf a y 
  | x<a = Branch (Leaf x y) Empty a b
  | otherwise = Branch Empty (Leaf x y) a b
-- Insert into branch, if same ins here, elif less ins left, else ins right
ins x y (Branch left right a b)
  | x==a = (Branch left right a y)
  | x<a = (Branch (ins x y left) right a b) 
  | otherwise = (Branch left (ins x y right) a b) 

   
-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => BinTree k d -> k -> m d
-- Search in empty tree
lkp Empty _ = fail "Nothing"
-- Search in a leaf, if not current no match
lkp (Leaf a b) k = do 
  if k==a then do 
    return b
  else do 
    fail "Nothing"
-- Search in a branch, if same return, elif small return lkp left, else return lkp right
lkp (Branch left right a b) k= do
  if k==a then do
    return b
  else if k<a then do
    val <- lkp left k
    return val
  else do
    val <- lkp right k
    return val
-- Part 3 : Tail-Recursive Statistics

{-
   It is possible to compute BOTH average and standard deviation
   in one pass along a list of data items by summing both the data
   and the square of the data.
-}
twobirdsonestone :: Double -> Double -> Int -> (Double, Double)
twobirdsonestone listsum sumofsquares len
 = (average,sqrt variance)
 where
   nd = fromInteger $ toInteger len
   average = listsum / nd
   variance = sumofsquares / nd - average * average

{-
  The following function takes a list of numbers  (Double)
  and returns a triple containing
   the length of the list (Int)
   the sum of the numbers (Double)
   the sum of the squares of the numbers (Double)

   You will need to update the definitions of init1, init2 and init3 here.
-}
getLengthAndSums :: [Double] -> (Int,Double,Double)
getLengthAndSums ds = getLASs init1 init2 init3 ds
init1 = 0
init2 = 0.0
init3 = 0.0

{-
  Implement the following tail-recursive  helper function
-}
getLASs :: Int -> Double -> Double -> [Double] -> (Int,Double,Double)
-- Stop when list empty
getLASs len sn sqn [] = (len,sn,sqn)
-- Iterate, add len, sq and sqn, remove head each iteration
getLASs len sn sqn (x:xs) = getLASs (len+1) (sn+x) (sqn+(x*x)) xs


-- Final Hint: how would you use a while loop to do this?
--   (assuming that the [Double] was an array of double)
