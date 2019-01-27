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
    
    fileprivate struct ClayPosition: Hashable {
        let position: CellPosition
        let type: CellType
        
        var hashValue: Int {
            return position.x ^ position.x
        }
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
        
        var isWaterAtBottom: Bool {
            let bottomRow = cells.last!
            return bottomRow.contains(where: { $0.isWater })
        }
        
        var numberOfWetCells: Int {
            let flattenedCells = cells.flatMap { $0 }
            return flattenedCells.reduce(0) {
                if $1 == .waterPassed {
                    return $0 + 1
                } else if $1 == .settledWater {
                    return $0 + 1
                } else {
                    return $0
                }
            }
        }
        
        init(lines: [String], springX: Int, springY: Int) {
            self.springY = springY
            var cellPositions: Set<ClayPosition> = Set()
            
            lines.forEach {
                buildLine(line: $0, cellPositions: &cellPositions)
            }
            
            cellPositions.insert(ClayPosition(position: CellPosition(x: springX, y: springY), type: .spring))
            
            print(cellPositions.first)
            
            // Now turn it into the 2D array we use going forward
            let xOffset = cellPositions.sorted(by: { $0.position.x < $1.position.x }).first!.position.x
            let xSize = cellPositions.sorted(by: { $0.position.x > $1.position.x }).first!.position.x - xOffset
            let yOffset = cellPositions.sorted(by: { $0.position.y < $1.position.y }).first!.position.y
            let ySize = cellPositions.sorted(by: { $0.position.y > $1.position.y }).first!.position.y - yOffset
            
            for y in 0...ySize {
                cells.append([])
                for x in 0...xSize {
                    if let cell = cellPositions.first(where: { $0.position.y == y+yOffset && $0.position.x == x+xOffset }) {
                        cells[y].append(cell.type)
                    } else {
                        cells[y].append(.sand)
                    }
                }
            }
            
            maxY = ySize
        }
        
        private func buildLine(line: String, cellPositions: inout Set<ClayPosition>) {
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
        
        private func buildClayFromRange(xFrom: Int, xTo: Int, yFrom: Int, yTo: Int, cellPositions: inout Set<ClayPosition>) {
            for x in xFrom...xTo {
                for y in yFrom...yTo {
                    cellPositions.insert(ClayPosition(position: CellPosition(x: x, y: y), type: .clay))
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
            if (cellBeneath == .clay || cellBeneath == .settledWater) && cells[y][x + 1] == .sand {
                cells[y][x + 1] = .waterPassed
                dripFrom(x: x + 1, y: y)
            }
            
            if (cellBeneath == .clay || cellBeneath == .settledWater) && cells[y][x - 1] == .sand {
                cells[y][x - 1] = .waterPassed
                dripFrom(x: x - 1, y: y)
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
            for _ in 0..<cells.count {
                print("=", terminator: "")
            }
            print()
        }
    }
}
