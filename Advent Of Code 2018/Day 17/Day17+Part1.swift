//
//  Day17+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day17 {
    struct Part1: Solveable {
        func go() -> String {
            let lines = linesFromFile(path: "Day 17/Input")
            
            let map = Map(lines: lines, springX: 500)
            
            repeat {
                map.dbgPrint()
                map.drip()
            } while map.isWaterAtBottom == false
            
            preconditionFailure()
        }
    }
}
