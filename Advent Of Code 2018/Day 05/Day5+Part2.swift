//
//  Day5+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 06/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day5 {
    struct Part2: Solveable {
        func go() -> String {
            let originalPolymer = linesFromFile(path: "Day 05/Input").first!
            
            var problemPolymerToLength: [Character: Int] = [:]
            for char in "abcdefghijklmnopqrstuvwxyz" {
                print("Currently checking \(char)")
                let polymerWithUnitRemoved = originalPolymer.replacingOccurrences(of: String(char), with: "", options: .caseInsensitive, range: nil)
                let reactedPolymer = Day5.removeUnits(polymer: polymerWithUnitRemoved)
                
                problemPolymerToLength[char] = reactedPolymer.count
            }
            
            let shortestOne = problemPolymerToLength.reduce(Int.max) {
                return min($0, $1.value)
            }
            
            return String(shortestOne)
        }
    }
}
