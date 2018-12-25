//
//  Day11+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 15/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day11 {
    struct Part1: Solveable {
        func go() -> String {
            let captureSize = 3
            
            let grid = Day11.getAllPowerLevels()
            let gridsPowerLevels = Day11.getGridsPowerLevels(grid: grid, captureSize: captureSize)
            let highestPowerLevelCell = Day11.getHighestPowerLevelCell(gridsPowerLevels: gridsPowerLevels)
            
            return highestPowerLevelCell.origin
        }
    }
}
