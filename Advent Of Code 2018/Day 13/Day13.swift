//
//  Day13.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 25/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day13 {
    struct CrashPosition: Hashable {
        let column: Int
        let line: Int
    }
    
    enum TrackPiece: Character {
        case verticalTrack = "|"
        case horizontalTrack = "-"
        case intersection = "+"
        case topLeftBottomRight = "/"
        case topRightBottomLeft = "\\" // N.B. This is an escaped single slash
        case blankSpace = " "
        
        init(char: Character) {
            if let value = TrackPiece(rawValue: char) {
                self = value
            } else if char == "v" || char == "^" {
                self = .verticalTrack
            } else if char == "<" || char == ">" {
                self = .horizontalTrack
            } else {
                preconditionFailure("Unrecognised symbol on map for \(char)")
            }
        }
    }
    
    static func buildTrack() -> [[TrackPiece]] {
        var grid: [[TrackPiece]] = []
        
        /// Ensure the grid is a complete rectangle, so we can jump around with array indexes
        func fixLineLength() {
            let longestLineLength = grid.reduce(Int.min) { max($0, $1.count) }
            
            for line in 0..<grid.count {
                while grid[line].count <= longestLineLength {
                    grid[line].append(.blankSpace)
                }
            }
        }
        
        let lines = linesFromFile(path: "Day 13/Input")
        
        for line in lines {
            // Using compactMap and gamling that everything is fine, as any errors will be lost
            let gridLine = line.map { TrackPiece(char: $0) }
            grid.append(gridLine)
        }
        
        fixLineLength()
        
        return grid
    }
    
    static func buildCarts() -> Set<Cart> {
        var carts = Set<Cart>()
        let lines = linesFromFile(path: "Day 13/Input")
        
        for line in lines.enumerated() {
            for column in line.element.enumerated() {
                guard let cart = Cart(line: line.offset, column: column.offset, symbol: column.element) else {
//                        print("Skipping char '\(column.element)' as not a cart")
                    continue
                }
                carts.insert(cart)
            }
        }
        
        return carts
    }
    
    static func rotateCartsIfNecessary(carts: Set<Cart>, grid: [[TrackPiece]]) {
        for cart in carts {
            if grid[cart.line][cart.column] == .intersection {
                cart.handleIntersection()
            } else if grid[cart.line][cart.column] == .topRightBottomLeft {
                switch cart.direction {
                case .up,
                     .down:
                    cart.turnLeft()
                case .right,
                     .left:
                    cart.turnRight()
                }
            } else if grid[cart.line][cart.column] == .topLeftBottomRight {
                switch cart.direction {
                case .up,
                     .down:
                    cart.turnRight()
                case .right,
                     .left:
                    cart.turnLeft()
                }
            }
        }
    }
    
    static func firstCrashPosition(carts: Set<Cart>, in grid: [[TrackPiece]]) -> CrashPosition? {
        var occupiedSpaces = Set<CrashPosition>()
        for cart in carts {
            let cartPos = CrashPosition(column: cart.column, line: cart.line)
            if occupiedSpaces.contains(cartPos) {
                return cartPos
            } else {
                occupiedSpaces.insert(cartPos)
            }
        }
        
        return nil
    }
    
    static func debugPrint(track: [[TrackPiece]], with carts: Set<Cart>) {
        print()
        for line in track.enumerated() {
            for column in line.element.enumerated() {
                if carts.filter({ $0.line == line.offset && $0.column == column.offset }).count > 1 {
                    print("X", terminator: "")
                } else if let cart = carts.first(where: { $0.line == line.offset && $0.column == column.offset }) {
                    print(cart.direction.symbol, terminator: "")
                } else {
                    print(column.element.rawValue, terminator: "")
                }
            }
            print()
        }
    }
}
