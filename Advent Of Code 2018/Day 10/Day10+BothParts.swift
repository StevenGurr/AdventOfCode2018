//
//  Day10+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 14/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day10 {
    struct BothParts: Solveable {
        func go() -> String {
            
            let input = linesFromFile(path: "Day 10/Input")
            var points = input.map { Point(rawData: $0) }
            
            var printer = PointPrinter(points: points)
            var lastPrinter = PointPrinter(points: [])
            var counter = -1
            
            repeat {
                lastPrinter = printer
                points = points.map { $0.stepped() }
                printer = PointPrinter(points: points)
                counter += 1
            } while printer.skySize < lastPrinter.skySize
            
            lastPrinter.print()
            
            print()
            print("Part 2 answer is \(counter) seconds were needed.")
            
            return "See Console"
        }
    }
}
