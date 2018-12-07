//
//  Day6+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 07/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day6 {
    struct Part2: Solveable {
        func go() -> String {
            let lines = linesFromFile(path: "Day 06/Input")
            
            guard let coords = try? lines.map(Day6.Coords.init) else {
                preconditionFailure("Failed to load coords")
            }
            
            let maxX = coords.reduce(0) { max($0, $1.x) }
            let maxY = coords.reduce(0) { max($0, $1.y) }
            
            var grid = Day6.buildGridUpTo(x: maxX, y: maxY)
            
            coords.forEach {
                grid[$0.x][$0.y] = .place($0)
            }
            
            Day6.populateOtherSpacesPart2(grid: &grid, places: coords)
            
//            Day6.dbgPrint(grid: grid)
            
            let distanceThreshold = 10000
            // For each cell in the grid, add up all the distances, and return a match for the cell if the distance is under the threshold
            let matches = grid.flatMap({ $0 }).filter {
                guard case let .allDistances(distances) = $0 else {
                    preconditionFailure("Should only have 'allDistances' in the aray now")
                }
                
                let totalDistances = distances.reduce(0, { return $0 + $1.distance })
                return totalDistances < distanceThreshold
            }
            
            return String(matches.count)
        }
    }
}
