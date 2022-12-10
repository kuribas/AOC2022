import System.File.ReadWrite
import Data.String
import Data.List1
import System

readInts : String -> List (List Int)
readInts s = 
  map (mapMaybe parseInteger) $ toList $ split null $ lines s

max3 : List Int -> Int -> List Int
max3 l x = take 3 $ reverse $ sort (x :: l)

maxSum : String -> Int
maxSum s = 
  sum $ foldl max3 [0] $ map sum $ readInts s

main : IO ()
main = do
  args <- getArgs
  let (file :: _) = drop 1 args | [] => printLn "No file provided!"
  (Right contents) <- readFile file | (Left error) => printLn error
  printLn $ maxSum contents
  
{-
idris2 part2.idr -o part2
$ build/exec/part2 /tmp/input 
-}
