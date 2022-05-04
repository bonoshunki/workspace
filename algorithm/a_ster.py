import numpy as np
import random

eight_puzzle = list(range(0, 9))
random.shuffle(eight_puzzle)


def calc_heuristic(eight_puzzle):
    acc_list = list(range(0, 9))
    heuristic = acc_list & eight_puzzle
    print(heuristic)


calc_heuristic(eight_puzzle)
print(eight_puzzle)
