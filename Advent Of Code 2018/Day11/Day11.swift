//
//  Day11.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 15/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day11 {
    struct Grid {
        let powerLevels: [[Int]]
        let partialSums: [[Int]]
    }
    
    static let gridSize = 300
    static let serialNumber = 2187
    
    static func getAllPowerLevels() -> Grid {
        var allPowerLevels: [[Int]] = []
        
        for x in 0..<gridSize {
            allPowerLevels.append([])
            for y in 0..<gridSize {
                allPowerLevels[x].append(getPowerLevelForCell(x: x+1, y: y+1))
            }
        }
        
        let partialSums: [[Int]] = calculatePartialSums(from: allPowerLevels)
        return Grid(powerLevels: allPowerLevels, partialSums: partialSums)
    }
    
    static func calculatePartialSums(from allPowerLevels: [[Int]]) -> [[Int]] {
        // HUGE thanks to the neat explanation here
        // https://www.codeproject.com/Articles/441226/Haar-feature-Object-Detection-in-Csharp#integral
        var partialSums: [[Int]] = []
        
        let startTime = NSDate()
        print("Building partial sums. This could take a minute… ", terminator: "")
        for x in 0..<allPowerLevels.count {
            partialSums.append([])
            for y in 0..<allPowerLevels[x].count {
                let ps = calculatePartialSums(from: allPowerLevels, targetX: x, targetY: y)
                partialSums[x].append(ps)
            }
        }
        
        print("Done!")
        print("Took \(Int(-startTime.timeIntervalSinceNow)) seconds 🙄")
        return partialSums
    }
    
    static func calculatePartialSums(from allPowerLevels: [[Int]], targetX: Int, targetY: Int) -> Int {
        var total = 0
        for x in 0...targetX {
            for y in 0...targetY {
                total += allPowerLevels[x][y]
            }
        }
        return total
    }
    
    static func getHighestPowerLevelCell(gridsPowerLevels: [String: Int]) -> (origin: String, value: Int) {
        var highestPowerLevel = Int.min
        var highestPowerLevelCellIndex = ""
        
        gridsPowerLevels.forEach {
            if $0.value > highestPowerLevel {
                highestPowerLevel = $0.value
                highestPowerLevelCellIndex = $0.key
            }
        }
        
        return (origin: highestPowerLevelCellIndex, value: highestPowerLevel)
    }
    
    static private func getPowerLevelForCell(x: Int, y: Int) -> Int {
        let rackId = getRackId(for: x)
        var powerLevel = getPowerLevel(forRackId: rackId, yCoordinate: y)
        powerLevel += serialNumber
        powerLevel *= rackId
        powerLevel = getHundredsDigit(from: powerLevel)
        powerLevel -= 5
        
        return powerLevel
    }
    
    static func getGridsPowerLevels(grid: Grid, captureSize: Int) -> [String: Int] {
        var gridsPowerLevels: [String: Int] = [:] // Store the index as a string for lazy/convenience reasons
        let gridSize = grid.powerLevels.count
        
        for x in 0..<(gridSize-captureSize) {
            for y in 0..<gridSize-captureSize {
                
                let bottomRight = grid.partialSums[x+captureSize-1][y+captureSize-1]
                let topRight = grid.partialSums[x+captureSize-1][safe: y-1] ?? 0
                let bottomLeft = grid.partialSums[safe: x-1]?[y+captureSize-1] ?? 0
                let topLeft = grid.partialSums[safe: x-1]?[safe: y-1] ?? 0
                
                gridsPowerLevels["\(x+1),\(y+1)"] = bottomRight-topRight-bottomLeft+topLeft
            }
        }
        
        return gridsPowerLevels
    }
    
    // MARK: - Helpers
    
    static private func getRackId(for xCoordinate: Int) -> Int {
        return xCoordinate + 10
    }
    
    static private func getPowerLevel(forRackId rackId: Int, yCoordinate: Int) -> Int {
        return rackId * yCoordinate
    }
    
    static private func getHundredsDigit(from number: Int) -> Int {
        var mutableNumber = number
        mutableNumber %= 1000 // Mod 1000 to strip everything above 1000
        mutableNumber /= 100 // Divide by 100 to lossily loose the lower two digits
        return mutableNumber
    }
}
