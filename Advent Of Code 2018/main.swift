//
//  main.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

let projectRootPath = "/Users/steven/Advent Of Code/Advent Of Code 2018/Advent Of Code 2018"

let puzzle: Solveable = Day1.Part2()

if let result = puzzle.go() {
    print("The answer is: \(result)")
} else {
    print("No return value from go()")
}
print()
