//
//  Day6+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 07/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day6 {
    struct Part1: Solveable {
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
            
            Day6.populateOtherSpacesPart1(grid: &grid, places: coords)
            
//            Day6.dbgPrint(grid: grid)
            
            let infiniteOnes = findInfiniteOnes(grid: grid)
            
            let coordsWithInfinitesRemoved = coords.filter({ infiniteOnes.contains($0) == false })
            let scores = countReferencesTo(places: coordsWithInfinitesRemoved, on: grid)
            let highestArea = scores.sorted(by: { $0.count > $1.count }).first!.count
            
            return String(highestArea)
        }
        
        private func countReferencesTo(places: [Coords], on grid: [[PlaceOrSpace]]) -> [(place: Coords, count: Int)] {
            let flatGrid = grid.flatMap { $0 }
            
            let placesAndCounts = places.map { (place: $0, count: countReferencesTo(place: $0, on: flatGrid)) }
            
            return placesAndCounts
        }
        
        private func countReferencesTo(place: Coords, on flatGrid: [PlaceOrSpace]) -> Int {
            return flatGrid.reduce(0) { counter, currentCoords in
                if case let .knownClosest(coords) = currentCoords, coords == place {
                    return counter + 1
                }
                return counter
            }
        }
        
        private func findInfiniteOnes(grid: [[PlaceOrSpace]]) -> Set<Coords> {
            var result = Set<Coords>()
            
            // left edge - x = 0
            for y in 0..<grid[0].count {
                if case let .knownClosest(coords) = grid[0][y] {
                    result.insert(coords)
                }
            }
            
            // top edge - y = 0
            for x in 0..<grid.count {
                if case let .knownClosest(coords) = grid[x][0] {
                    result.insert(coords)
                }
            }
            
            // right edge - x = count-1
            let endX = grid.count-1
            for y in 0..<grid[endX].count {
                if case let .knownClosest(coords) = grid[endX][y] {
                    result.insert(coords)
                }
            }
            
            // bottom ege - y = count-1
            let endY = grid[0].count-1
            for x in 0..<grid.count {
                if case let .knownClosest(coords) = grid[x][endY] {
                    result.insert(coords)
                }
            }
            
            return result
        }
    }
}
