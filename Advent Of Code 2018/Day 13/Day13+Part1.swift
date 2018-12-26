//
//  Day13+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 25/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day13 {
    class Part1: Solveable {
        var grid: [[TrackPiece]] = []
        var carts = Set<Cart>()
        
        func go() -> String {
            grid = buildTrack()
            carts = Day13.buildCarts()
            
//            Day13.debugPrint(track: grid, with: carts)
            
            repeat {
                tick(carts: carts, grid: grid)
//                Day13.debugPrint(track: grid, with: carts)
            } while Day13.firstCrashPosition(carts: carts, in: grid) == nil
            
            guard let crashPosition = Day13.firstCrashPosition(carts: carts, in: grid) else {
                preconditionFailure("Somehow got here without a crash happening yet")
            }
            
            return "\(crashPosition.column),\(crashPosition.line)"
        }
        
        private func tick(carts: Set<Cart>, grid: [[TrackPiece]]) {
            var cartsToMove = Set<Cart>(carts)
            
            for line in 0..<grid.count {
                for column in 0..<grid[line].count {
                    let cartsAtThisPoint = cartsToMove.filter { $0.line == line && $0.column == column }
                    for cart in cartsAtThisPoint {
                        switch cart.direction {
                        case .up:
                            cart.line -= 1
                        case .down:
                            cart.line += 1
                        case .left:
                            cart.column -= 1
                        case .right:
                            cart.column += 1
                        }
                        
                        cartsToMove.remove(cart)
                    }
                }
            }
            
            Day13.rotateCartsIfNecessary(carts: carts, grid: grid)
        }
    }
}
