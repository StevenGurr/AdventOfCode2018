//
//  Day17+Map.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day17 {
    class Map {
        var cells: [[Cell]] = []
        private var head: Cell!
        
        var isWaterAtBottom: Bool {
            let flattened = cells.flatMap({$0})
            let maxY = flattened.sorted(by: { $0.y > $1.y }).first!.y
            return maxY == head.y
        }
        
        init(lines: [String], springX: Int) {
            var cells: Set<Cell> = Set()
            lines.forEach {
                buildLine(line: $0, cells: &cells)
            }
            setSpring(x: springX, cells: &cells)
            fillSpacesWithSand(cells: &cells)
            convertToArray(cells: cells)
        }
        
        private func buildLine(line: String, cells: inout Set<Cell>) {
            let bits = line.capture(from: "^([xy])=(\\d+), ([xy])=(\\d+).{2}(\\d+)$")
            let firstValue = Int(bits[1])!
            let secondValueFrom = Int(bits[3])!
            let secondValueTo = Int(bits[4])!
            
            if bits[0] == "x" {
                buildClayFromRange(xFrom: firstValue, xTo: firstValue, yFrom: secondValueFrom, yTo: secondValueTo, cells: &cells)
            } else {
                buildClayFromRange(xFrom: secondValueFrom, xTo: secondValueTo, yFrom: firstValue, yTo: firstValue, cells: &cells)
            }
        }
        
        private func buildClayFromRange(xFrom: Int, xTo: Int, yFrom: Int, yTo: Int, cells: inout Set<Cell>) {
            for x in xFrom...xTo {
                for y in yFrom...yTo {
                    let cell = Cell(x: x, y: y, type: .clay)
                    cells.insert(cell)
                }
            }
        }
        
        private func fillSpacesWithSand(cells: inout Set<Cell>) {
            let minX = cells.sorted(by: { $0.x < $1.x }).first!.x
            let maxX = cells.sorted(by: { $0.x > $1.x }).first!.x
            let minY = cells.sorted(by: { $0.y < $1.y }).first!.y
            let maxY = cells.sorted(by: { $0.y > $1.y }).first!.y
            
            for x in minX...maxX {
                for y in minY...maxY {
                    if cells.contains(where: { $0.x == x && $0.y == y }) == false {
                        cells.insert(Cell(x: x, y: y, type: .sand))
                    }
                }
            }
        }
        
        private func setSpring(x: Int, cells: inout Set<Cell>) {
            // Insert the cell one row above the current top row
            let minY = cells.sorted(by: { $0.y < $1.y }).first!.y
            
            let springCell = Cell(x: x, y: minY-1, type: .spring)
            cells.insert(springCell)
            self.head = springCell
        }
        
        private func convertToArray(cells cellsSet: Set<Cell>) {
            func cellAt(x: Int, y: Int) -> Cell {
                let cellsHere = cellsSet.filter { $0.x == x && $0.y == y }
                guard cellsHere.count == 1 else {
                    preconditionFailure()
                }
                return cellsHere.first!
            }
            
            let minX = cellsSet.sorted(by: { $0.x < $1.x }).first!.x
            let maxX = cellsSet.sorted(by: { $0.x > $1.x }).first!.x
            let minY = cellsSet.sorted(by: { $0.y < $1.y }).first!.y
            let maxY = cellsSet.sorted(by: { $0.y > $1.y }).first!.y
            let xOffset = cellsSet.sorted(by: { $0.x < $1.x }).first!.x
            
            for y in minY...maxY {
                cells.append([])
                for x in minX...maxX {
                    cells[y].append(cellAt(x: x, y: y))
                }
            }
        }
        
        func drip() {
            let flattened = cells.flatMap({$0})
            let xOffset = flattened.sorted(by: { $0.x < $1.x }).first!.x
            let yOffset = flattened.sorted(by: { $0.y < $1.y }).first!.y
            let headX = head.x - xOffset
            let headY = head.y - yOffset
            
            let newCell: Cell
            
            // Try down
            if canExtendTo(y: headY+1, x: headX) {
                newCell = Cell(x: head.x, y: head.y+1, type: .waterPassed)
                cells[headY+1][headX] = newCell
            // Try left
            } else if canExtendTo(y: headY, x: headX-1) {
                newCell = Cell(x: head.x-1, y: head.y, type: .settledWater)
                cells[headY][headX-1] = newCell
            // Try right
            } else if cells[headY][headX+1].type == .sand {
                preconditionFailure()
            // Try up
            } else if cells[headY-1][headX].type == .sand {
                preconditionFailure()
            // Completely failed
            } else {
                preconditionFailure()
            }
            
            head = newCell
        }
        
        private func canExtendTo(y: Int, x: Int) -> Bool {
            switch cells[y][x].type {
            case .sand,
                 .waterPassed:
                return true
            default:
                return false
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
