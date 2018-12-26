//
//  Day13+Cart.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 26/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day13 {
    class Cart {
        enum Direction {
            case up
            case down
            case left
            case right
            
            var symbol: Character {
                switch self {
                case .up:
                    return "^"
                case .down:
                    return "v"
                case .left:
                    return "<"
                case .right:
                    return ">"
                }
            }
            
            fileprivate func turnedLeft() -> Direction {
                switch self {
                case .up:
                    return .left
                case .down:
                    return .right
                case .left:
                    return .down
                case .right:
                    return .up
                }
            }
            
            fileprivate func turnedRight() -> Direction {
                switch self {
                case .up:
                    return .right
                case .down:
                    return .left
                case .left:
                    return .up
                case .right:
                    return .down
                }
            }
        }
        
        convenience init?(line: Int, column: Int, symbol: Character) {
            switch symbol {
            case Direction.up.symbol:
                self.init(line: line, column: column, direction: .up)
            case Direction.down.symbol:
                self.init(line: line, column: column, direction: .down)
            case Direction.left.symbol:
                self.init(line: line, column: column, direction: .left)
            case Direction.right.symbol:
                self.init(line: line, column: column, direction: .right)
                
            // Not a valid cart symbol - this is completely fine
            default:
                return nil
            }
        }
        
        init(line: Int, column: Int, direction: Direction) {
            self.line = line
            self.column = column
            self.direction = direction
        }
        
        var line: Int
        var column: Int
        var direction: Direction
        var turnCounter = 0
        
        func handleIntersection() {
            switch turnCounter % 3 {
            case 0:
                direction = direction.turnedLeft()
            case 1:
                break
            case 2:
                direction = direction.turnedRight()
            default:
                preconditionFailure("Should never get here")
            }
            turnCounter += 1
        }
        
        func turnRight() {
            direction = direction.turnedRight()
        }
        
        func turnLeft() {
            direction = direction.turnedLeft()
        }
    }
}

extension Day13.Cart: Hashable {
    static func == (lhs: Day13.Cart, rhs: Day13.Cart) -> Bool {
        return lhs.line == rhs.line &&
            lhs.column == rhs.column &&
            lhs.direction == rhs.direction &&
            lhs.turnCounter == rhs.turnCounter
    }
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
