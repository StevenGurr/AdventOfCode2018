//
//  Day18+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 27/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day18 {
    struct Part2: Solveable {
        func go() -> String {
            let minutesToRun = 1000000000
            
            let lines = linesFromFile(path: "Day 18/Input")
            let area = Area(lines: lines)
            
            while true {
                if area.repititionStartOffset != nil {
                    print("Done!")
                    break
                }
                
                area.tick()
            }
            
            guard let repititionStartOffset = area.repititionStartOffset else {
                preconditionFailure("Should not be able to be here")
            }
            print("repititionStartOffset: \(repititionStartOffset)")
            
            let repititionSize = area.mutationHistory.count - repititionStartOffset
            print("Repitition size: \(repititionSize)")
            
            let indexInRepeating = (minutesToRun-repititionStartOffset) % repititionSize // -1 to match 0 indexed arrays
            print("position within repeating section: \(indexInRepeating)")
            let indexInArray = repititionStartOffset + indexInRepeating
            print("position within complete array: \(indexInArray)")
            let finalArea = area.mutationHistory[indexInArray]

            let woodedAreas = area.acresWith(type: .trees, in: finalArea)
            let lumberyards = area.acresWith(type: .lumberyard, in: finalArea)

            return "\(woodedAreas * lumberyards)"
        }
    }
}
