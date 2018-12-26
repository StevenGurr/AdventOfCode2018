//
//  Day13+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 27/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day13 {
    class Part2: Solveable {
        var grid: [[TrackPiece]] = []
        var carts = Set<Cart>()
        
        func go() -> String {
            var tickCount = 0
            grid = buildTrack()
            carts = Set(Day13.buildCarts())
            
//            Day13.debugPrint(track: grid, with: Array(carts))
            
            repeat {
                tick(carts: &carts, grid: grid)
                tickCount += 1
//                Day13.debugPrint(track: grid, with: Array(carts))
                
                if tickCount % 1000 == 0 {
                    print("Tick \(tickCount)")
                }
            } while carts.count > 1
            print("Tick \(tickCount)")
                        
            return "\(carts.first!.column),\(carts.first!.line)"
        }
        
        private func tick(carts: inout Set<Cart>, grid: [[TrackPiece]]) {
            var cartsToMove = Set<Cart>(carts)
            
            for line in 0..<grid.count {
                for column in 0..<grid[line].count {
                    var cartsAtThisPoint = cartsToMove.filter { $0.line == line && $0.column == column }
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
                        
                        if let crashPosition = Day13.firstCrashPosition(carts: carts, in: grid) {
                            print("Crash at \(crashPosition)")
                            let crashedCarts = carts.filter { $0.line == crashPosition.line && $0.column == crashPosition.column }
                            crashedCarts.forEach {
                                carts.remove($0)
                                cartsToMove.remove($0)
                                cartsAtThisPoint.remove($0)
                            }
                        }
                    }
                }
            }
            
            rotateCartsIfNecessary(carts: carts, grid: grid)
        }
    }
}
