# Author: Lucas Sato
# Version 2018-02-21
#
# Program for an assignment for course CEE32A - The Psychology of
# Architecture, at Stanford University, Winter 2018.
#
# Assignment 5 - Internal & External Mapping
# The assignment consists in analyzing one of the essays we wrote for
# this class and classify each sentence we wrote according to its
# primary origin, and thus assess how we think and understand the world
# around us most of the time.

import re
import json

def main():
    TEXT_PATH = "text.txt"

    LENSES = {
        "P": "Personal Memory",
        "L": "Learned Skill",
        "N": "Intuition",
        "M": "Insight in the Moment",
        "S": "Sensation",
        "X": "Direct Experience",
        "A": "Assumption",
        "B": "Belief",
        "F": "Feeling/Emotion",
        "I": "Imagery",
        "H": "Heresay",
        "O": "Other"
    }

    lens_count = {
        "P": 0,
        "L": 0,
        "N": 0,
        "M": 0,
        "S": 0,
        "X": 0,
        "A": 0,
        "B": 0,
        "F": 0,
        "I": 0,
        "H": 0,
        "O": 0
    }

    lines = []
    with open(TEXT_PATH, "r") as text:
        lines = re.findall(r"[\w\d\s\,\:\;\-\'\"”“’]+", text.read())
        # Thanks to @RichieHindle on https://goo.gl/4QSTRL
    for line in lines:
        line = line.strip("\n").strip(" ")
        if line != "":
            print("\n\n" + line)
            while True:
                try:
                    lens_count[input().upper()] += 1
                    break
                except KeyError:
                    print("That's not a lens! Try again!")

    with open("lens_count.json", "w") as out:
        json.dump(lens_count, out)


if __name__ == "__main__":
    main()
