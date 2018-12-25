//
//  Day11+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 15/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day11 {
    struct Part2: Solveable {
        struct XYSize: Hashable {
            let x: Int
            let y: Int
            let size: Int
        }
        
        func go() -> String {
            let grid = Day11.getAllPowerLevels()

            var highestCapturedValue = Int.min
            var highestCapturedCellOrigin = ""
            var highestCapturedGridSize = 0
            
            // Start at 1 as you can't capture a zero size grid
            for captureSize in (1..<Day11.gridSize) {
                print("Checking capture size of \(captureSize)… ", terminator: "")

                let gridsPowerLevels = Day11.getGridsPowerLevels(grid: grid, captureSize: captureSize)
                let highestPowerLevelCell = Day11.getHighestPowerLevelCell(gridsPowerLevels: gridsPowerLevels)

                if highestPowerLevelCell.value > highestCapturedValue {
                    print("New best!")
                    highestCapturedValue = highestPowerLevelCell.value
                    highestCapturedCellOrigin = highestPowerLevelCell.origin
                    highestCapturedGridSize = captureSize
                } else {
                    print()
                }
            }

            return "\(highestCapturedCellOrigin),\(highestCapturedGridSize)"
        }
    }
}
