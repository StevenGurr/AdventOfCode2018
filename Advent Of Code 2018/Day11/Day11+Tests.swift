//
//  Day11+Tests.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 16/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day11 {
    struct Tests {
        func test() {
            var powerLevels: [[Int]] = []
            // First column
            powerLevels.append([])
            powerLevels[0].append(-31)
            powerLevels[0].append(-21)
            powerLevels[0].append(31)
            powerLevels[0].append(45)
            
            // Second column
            powerLevels.append([])
            powerLevels[1].append(-40)
            powerLevels[1].append(-12)
            powerLevels[1].append(21)
            powerLevels[1].append(-32)
            
            // Third column
            powerLevels.append([])
            powerLevels[2].append(41)
            powerLevels[2].append(15)
            powerLevels[2].append(-13)
            powerLevels[2].append(7)
            
            // Fourth column
            powerLevels.append([])
            powerLevels[3].append(19)
            powerLevels[3].append(11)
            powerLevels[3].append(35)
            powerLevels[3].append(42)
            
            let partialSums = Day11.calculatePartialSums(from: powerLevels)
            print(partialSums)
            
            let grid = Grid(powerLevels: powerLevels, partialSums: partialSums)
            let grids = Day11.getGridsPowerLevels(grid: grid, captureSize: 2)
            print(grids)
        }
    }
}
