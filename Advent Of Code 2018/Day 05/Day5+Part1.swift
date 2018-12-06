//
//  Day5+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 05/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day5 {
    struct Part1: Solveable {
        func go() -> String {
            
            let polymer = linesFromFile(path: "Day 05/Input").first!
            
            let shortened = Day5.removeUnits(polymer: polymer)
            
            return String(shortened.count)
        }
    }
}
