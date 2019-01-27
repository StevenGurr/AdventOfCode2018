//
//  Day17+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 27/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day17 {
    struct Part2: Solveable {
        func go() -> String {
            let lines = linesFromFile(path: "Day 17/Input")
            
            let map = Map(lines: lines, springX: 500, springY: 0)
            
            map.drip()
            
            let settledCells = map.numberOfSettledCells
            return String(settledCells)
        }
    }
}
