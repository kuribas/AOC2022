#pyright: strict
from functools import reduce
import sys
from typing import List, TypeVar

A = TypeVar('A')

def inBoth(rucksack : str) -> str:
    middle : int = int(len(rucksack) / 2)
    c = set(rucksack[:middle]).intersection(set(rucksack[middle:]))
    if(len(c) == 1):
        return c.pop()
    else:
        raise ValueError("expected 1, found " + str(len(c)) + " common characters in " + rucksack)

def inAll(rucksacks : List[str]) -> str:
    c : set[str] = set(rucksacks[0]).difference(inBoth(rucksacks[0]))
    for r in rucksacks[1:]:
        c = set(r).difference(inBoth(r)).intersection(c)
    if(len(c) == 1):
        return c.pop()
    else:
        raise ValueError("found " + str(len(c)) + " common characters in " + str(rucksacks) + ": " + str(c))

def priority(item : str) -> int:
    if item.islower():
        return ord(item) - ord("a") + 1
    else:
        return ord(item) - ord("A") + 27

def group3(items : List[A]) -> List[List[A]]:
    return [items[i:i+3] for i in range(0, len(items), 3)]   

def prioritySum(items : List[str]) -> int:
    return sum(priority(inAll(item)) for item in group3(items))
    
def main(input : str) -> None:
    with open(input) as f:
        lines = [l.strip() for l in f.readlines()]
        print(prioritySum(lines))
        
main(sys.argv[1])