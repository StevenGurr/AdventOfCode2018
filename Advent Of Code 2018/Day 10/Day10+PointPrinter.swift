//
//  Day10+PointPrinter.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 14/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day10 {
    struct PointPrinter {
        let points: [Point]
        let minX: Int
        let maxX: Int
        let minY: Int
        let maxY: Int
        
        init(points: [Point]) {
            self.points = points
            
            self.minX = points.reduce(Int.max) { min($0, $1.position.x) }
            self.maxX = points.reduce(0) { max($0, $1.position.x) }
            self.minY = points.reduce(Int.max) { min($0, $1.position.y) }
            self.maxY = points.reduce(0) { max($0, $1.position.y) }
        }
        
        lazy var skySize: SkySize = {
            return SkySize(width: maxX-minX, height: maxY-minY)
        }()
        
        func print() {
            Swift.print("\n")
            (minY...maxY).forEach { y in
                (minX...maxX).forEach { x in
                    if points.contains(where: { $0.position.x == x && $0.position.y == y }) {
                        Swift.print("##", terminator: "")
                    } else {
                        Swift.print("..", terminator: "")
                    }
                }
                Swift.print("\n")
            }
        }
    }
}
