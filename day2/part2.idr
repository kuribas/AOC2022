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

parseHand : String -> Maybe Hand
parseHand "A" = Just Rock
parseHand "B" = Just Paper
parseHand "C" = Just Scissors
parseHand _ = Nothing

parseOutcome : String -> Maybe Outcome
parseOutcome "X" = Just Loss
parseOutcome "Y" = Just Draw
parseOutcome "Z" = Just Win
parseOutcome _ = Nothing

handFromOutcome : Hand -> Outcome -> Hand
handFromOutcome h1 oc = case (handScore h1 + outcomeOffset oc - 1) `mod` 3 of
  0 => Rock
  1 => Paper
  2 => Scissors
  _ => Rock -- impossible
  where outcomeOffset : Outcome -> Int
        outcomeOffset Draw = 0
        outcomeOffset Win = 1
        outcomeOffset Loss = -1

readHand : String -> Maybe (Hand, Hand)
readHand s = case words s of
  [h1, h2] => let hand = parseHand h1
                  outcome = parseOutcome h2
                  hand2 = handFromOutcome <$> hand <*> outcome
              in (,) <$> hand <*> hand2
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
$ idris2 part2.idr -o part2
$ ./build/exec/part2 /tmp/input 
11666
-}
