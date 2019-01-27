//
//  Day17+Map.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day17 {
    fileprivate struct CellPosition: Hashable {
        var x: Int
        var y: Int
    }
    
    class Map {
        private let springY: Int
        private var cells: [[CellType]] = []
        private var maxY = 0
        
        private lazy var springPosition: CellPosition = {
            for x in 0..<cells[0].count where cells[0][x] == .spring {
                return CellPosition(x: x, y: 0)
            }
            preconditionFailure()
        }()
        
        var numberOfWetCells: Int {
            return numberOfSettledCells + numberOfWaterPassedCells
        }
        
        var numberOfSettledCells: Int {
            let flattenedCells = cells.flatMap { $0 }
            return flattenedCells.reduce(0) {
                if $1 == .settledWater {
                    return $0 + 1
                } else {
                    return $0
                }
            }
        }
        
        var numberOfWaterPassedCells: Int {
            let flattenedCells = cells.flatMap { $0 }
            return flattenedCells.reduce(0) {
                if $1 == .waterPassed {
                    return $0 + 1
                } else {
                    return $0
                }
            }
        }
        
        init(lines: [String], springX: Int, springY: Int) {
            self.springY = springY
            var cellPositions: [CellPosition: CellType] = [:]
            
            lines.forEach {
                buildLine(line: $0, cellPositions: &cellPositions)
            }
            
            // Now turn it into the 2D array we use going forward
            let xOffset = cellPositions.keys.sorted(by: { $0.x < $1.x }).first!.x
            let xSize = cellPositions.keys.sorted(by: { $0.x > $1.x }).first!.x - xOffset + 1 // The water needs to be able to flow over the side of the right-most bit of clay
            let yOffset = cellPositions.keys.sorted(by: { $0.y < $1.y }).first!.y - 1 // There needs to be one line above the top bit of clay for the spring
            let ySize = cellPositions.keys.sorted(by: { $0.y > $1.y }).first!.y - yOffset
            
            cellPositions[CellPosition(x: springX, y: yOffset)] = .spring
            
            for y in 0...ySize {
                cells.append([])
                for x in 0...xSize {
                    if let cellType = cellPositions[CellPosition(x: x+xOffset, y: y+yOffset)] {
                        cells[y].append(cellType)
                    } else {
                        cells[y].append(.sand)
                    }
                }
            }
            
            maxY = ySize
        }
        
        private func buildLine(line: String, cellPositions: inout [CellPosition: CellType]) {
            let bits = line.capture(from: "^([xy])=(\\d+), ([xy])=(\\d+).{2}(\\d+)$")
            let firstValue = Int(bits[1])!
            let secondValueFrom = Int(bits[3])!
            let secondValueTo = Int(bits[4])!
            
            if bits[0] == "x" {
                buildClayFromRange(xFrom: firstValue, xTo: firstValue, yFrom: secondValueFrom, yTo: secondValueTo, cellPositions: &cellPositions)
            } else {
                buildClayFromRange(xFrom: secondValueFrom, xTo: secondValueTo, yFrom: firstValue, yTo: firstValue, cellPositions: &cellPositions)
            }
        }
        
        private func buildClayFromRange(xFrom: Int, xTo: Int, yFrom: Int, yTo: Int, cellPositions: inout [CellPosition: CellType]) {
            for x in xFrom...xTo {
                for y in yFrom...yTo {
                    cellPositions[CellPosition(x: x, y: y)] = .clay
                }
            }
        }
        
        func drip() {
            dripFrom(x: springPosition.x, y: springPosition.y)
        }
        
        fileprivate func dripFrom(x: Int, y: Int) {
            if y >= maxY {
                return
            }
            
            if cells[y + 1][x] == .sand {
                cells[y + 1][x] = .waterPassed
                dripFrom(x: x, y: y + 1)
            }
            
            let cellBeneath = cells[y + 1][x]
            if (cellBeneath == .clay || cellBeneath == .settledWater) && x+1 < cells[y].count && cells[y][x + 1] == .sand {
                cells[y][x + 1] = .waterPassed
                dripFrom(x: x + 1, y: y)
            }
            
            if (cellBeneath == .clay || cellBeneath == .settledWater) && cells[y][x - 1] == .sand {
                cells[y][x - 1] = .waterPassed
                dripFrom(x: x - 1, y: y)
            }
            
            if y >= maxY {
                return
            }
            
            if hasBothWalls(x: x, y: y) {
                fillLevel(x: x, y: y)
            }
        }
        
        private func hasBothWalls(x: Int, y: Int) -> Bool {
            return hasWall(x: x, y: y, xOffset: 1) && hasWall(x: x, y: y, xOffset: -1)
        }
        
        private func hasWall(x: Int, y: Int, xOffset: Int) -> Bool {
            var currentX = x
            while true {
                guard currentX < cells[y].count else {
                    return false
                }
                
                if cells[y][currentX] == .sand {
                    return false
                } else if cells[y][currentX] == .clay {
                    return true
                }
                currentX += xOffset
            }
        }

        private func fillLevel(x: Int, y: Int) {
            fillSide(x: x, y: y, xOffset: 1)
            fillSide(x: x, y: y, xOffset: -1)
        }
        
        private func fillSide(x: Int, y: Int, xOffset: Int) {
            var currentX = x
            while true {
                if cells[y][currentX] == .clay {
                    return
                }
                
                cells[y][currentX] = .settledWater
                currentX += xOffset
            }
        }

        func dbgPrint() {
            print()
            for y in 0..<cells.count {
                for x in 0..<cells[y].count {
                    print(cells[y][x].dbgChar, terminator: "")
                }
                print()
            }

            print()
//            for _ in 0..<cells[0].count {
//                print("=", terminator: "")
//            }
            print()
        }
    }
}
