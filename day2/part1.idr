import System.File.ReadWrite
import Data.String
import Data.List1
import System

data Hand = Rock | Paper | Scissors
data Outcome = Win | Loss | Draw

handScore : Hand -> Int
handScore Rock = 1
handScore Paper = 2
handScore Scissors = 3

calcOutcome : Hand -> Hand -> Outcome
calcOutcome h1 h2 = case (handScore h2 - handScore h1) `mod` 3 of
  0 => Draw
  1 => Win
  2 => Loss
  _ => Loss -- impossible
  
outcomeScore : Outcome -> Int
outcomeScore Loss = 0
outcomeScore Draw = 3
outcomeScore Win = 6

charHand1 : String -> Maybe Hand
charHand1 "A" = Just Rock
charHand1 "B" = Just Paper
charHand1 "C" = Just Scissors
charHand1 _ = Nothing

charHand2 : String -> Maybe Hand
charHand2 "X" = Just Rock
charHand2 "Y" = Just Paper
charHand2 "Z" = Just Scissors
charHand2 _ = Nothing

readHand : String -> Maybe (Hand, Hand)
readHand s = case words s of
  [h1, h2] => (,) <$> charHand1 h1 <*> charHand2 h2
  _ => Nothing

readHands : String -> List (Hand, Hand)
readHands s = mapMaybe readHand $ lines s

handsScore : (Hand, Hand) -> Int
handsScore (h1, h2) = outcomeScore (calcOutcome h1 h2) + handScore h2

totalScore : List (Hand, Hand) -> Int
totalScore h = sum $ map handsScore h

{- test:
λΠ> totalScore $ readHands $ unlines $ ["A Y", "B X", "C Z"]
15
-}

main : IO ()
main = do
  args <- getArgs
  let (file :: _) = drop 1 args | [] => printLn "No file provided!"
  (Right contents) <- readFile file | (Left error) => printLn error
  printLn $ totalScore $ readHands contents

{-
$ idris2 part1.idr -o part1
$ ./build/exec/part1 /tmp/input 
11666
-}
