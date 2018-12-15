//
//  Day10+Point.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 14/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day10 {
    struct Point {
        typealias Position = (x: Int, y: Int)
        typealias Velocity = (x: Int, y: Int)
        
        var position: Position
        let velocity: Velocity
        
        init(rawData: String) {
            let captures = rawData.capture(from: "position=<([\\s-\\d]+), ([\\s-\\d]+)> velocity=<([\\s-\\d]+), ([\\s-\\d]+)>")
            position = Position(x: captures[0].strippedAsInt, y: captures[1].strippedAsInt)
            velocity = Velocity(x: captures[2].strippedAsInt, y: captures[3].strippedAsInt)
        }
        
        init(position: Position, velocity: Velocity) {
            self.position = position
            self.velocity = velocity
        }
        
        func stepped() -> Point {
            let newX = position.x + velocity.x
            let newY = position.y + velocity.y
            let newPosition = Position(x: newX, y: newY)
            return Point(position: newPosition, velocity: velocity)
        }
    }
}

fileprivate extension String {
    var strippedAsInt: Int {
        return Int(trimmingCharacters(in: .whitespaces))!
    }
}
