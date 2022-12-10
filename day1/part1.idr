import System.File.ReadWrite
import Data.String
import Data.List1
import System

maxSum : String -> Int
maxSum s = 
  foldl max 0 $ map (sum . mapMaybe parseInteger) $ toList $ split null $ lines s

main : IO ()
main = do
  args <- getArgs
  let (file :: _) = drop 1 args | [] => printLn "No file provided!"
  (Right contents) <- readFile file | (Left error) => printLn error
  print $ maxSum contents
  
{-
 compile:
 idris2 part1.idr -o hello
 build/exec/hello input
-}
