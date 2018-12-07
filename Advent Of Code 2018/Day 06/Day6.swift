//
//  Day6.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 07/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day6 {
    struct Coords: Hashable, Equatable {
        let x: Int
        let y: Int
        
        init(coords: String) throws {
            let regex = try NSRegularExpression(pattern: "(\\d+), (\\d+)")
            let allMatches = regex.matches(in: coords, range: NSRange(location: 0, length: coords.count))
            
            guard let match = allMatches.first else {
                preconditionFailure("Didn't match regex")
            }
            
            x = Int(coords[Range(match.range(at: 1), in: coords)!])!
            y = Int(coords[Range(match.range(at: 2), in: coords)!])!
        }
        
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
    }
    
    enum PlaceOrSpace {
        case place(Coords)
        case unknown
        case knownClosest(Coords)
        case clash
        case allDistances([(coords: Day6.Coords, distance: Int)])
    }
    
    static func buildGridUpTo(x maxX: Int, y maxY: Int) -> [[PlaceOrSpace]] {
        var grid: [[PlaceOrSpace]] = []
        
        for x in 0...maxX {
            grid.insert([], at: x)
            for y in 0...maxY {
                grid[x].insert(.unknown, at: y)
            }
        }
        
        return grid
    }
    
    static func populateOtherSpacesPart1(grid: inout [[PlaceOrSpace]], places: [Coords]) {
        func distance(from: Coords, to: Coords) -> Int {
            return abs(from.x - to.x) + abs(from.y - to.y)
        }
        
        let maxX = grid.count
        let maxY = grid[0].count
        
        for x in 0..<maxX {
            for y in 0..<maxY {
//                guard case .unknown = grid[x][y] else {
////                    print("Skipping \(x),\(y) as it's known")
//                    continue
//                }
                
                let currentPos = Coords(x: x, y: y)
                let distances = places.map {
                    return (coords: $0, distance: distance(from: currentPos, to: $0))
                }
                let shortestDistances = distances.sorted(by: { $0.distance < $1.distance })
                let shortestDistance = shortestDistances.first!
                let totalOfThisLength = distances.filter({ $0.distance == shortestDistance.distance }).count
                if totalOfThisLength == 1 {
                    grid[x][y] = .knownClosest(shortestDistance.coords)
                } else {
                    grid[x][y] = .clash
                }
            }
        }
    }
    
    static func populateOtherSpacesPart2(grid: inout [[PlaceOrSpace]], places: [Coords]) {
        func distance(from: Coords, to: Coords) -> Int {
            return abs(from.x - to.x) + abs(from.y - to.y)
        }
        
        let maxX = grid.count
        let maxY = grid[0].count
        
        for x in 0..<maxX {
            for y in 0..<maxY {
                let currentPos = Coords(x: x, y: y)
                let distances = places.map {
                    return (coords: $0, distance: distance(from: currentPos, to: $0))
                }
                grid[x][y] = .allDistances(distances)
            }
        }
    }
    
    static func dbgPrint(grid: [[PlaceOrSpace]]) {
        let maxX = grid.count
        let maxY = grid[0].count
        
        print()
        for y in 0..<maxY {
            for x in 0..<maxX {
                switch grid[x][y] {
                case .place:
                    print("P", terminator: "")
                case .unknown:
                    print("U", terminator: "")
                case .knownClosest:
                    print("K", terminator: "")
                case .clash:
                    print(".", terminator: "")
                case .allDistances:
                    print("A", terminator: "")
                }
            }
            print()
        }
    }
}
