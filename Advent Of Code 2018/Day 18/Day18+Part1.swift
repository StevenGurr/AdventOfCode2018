//
//  Day18+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 27/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day18 {
    struct Part1: Solveable {
        func go() -> String {
            let minutesToRun = 10
            
            let lines = linesFromFile(path: "Day 18/Input")
            let area = Area(lines: lines)
            
            for _ in 0..<minutesToRun {
                area.tick()
            }
            area.dbgPrint()
            
            let woodedAreas = area.acresWith(type: .trees)
            let lumberyards = area.acresWith(type: .lumberyard)
            
            return "\(woodedAreas * lumberyards)"
        }
    }
}
