#pyright: strict
import sys
from typing import List

def inBoth(rucksack : str) -> str:
    middle : int = int(len(rucksack) / 2)
    c = set(rucksack[:middle]).intersection(set(rucksack[middle:]))
    if(len(c) == 1):
        return c.pop()
    else:
        raise ValueError("expected 1, found " + str(len(c)) + " common characters in " + rucksack)

def priority(item : str) -> int:
    if item.islower():
        return ord(item) - ord("a") + 1
    else:
        return ord(item) - ord("A") + 27

def prioritySum(items : List[str]) -> int:
    return sum(priority(inBoth(item)) for item in items)
    
def main(input : str) -> None:
    with open(input) as f:
        lines = f.readlines()
        print(prioritySum(lines))
        
main(sys.argv[1])