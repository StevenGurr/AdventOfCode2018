//
//  Day3.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 03/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day3 {
    struct Claim {
        let id: Int
        let left: Int
        let top: Int
        let width: Int
        let height: Int
        
        init(string: String) throws {
            let regex = try NSRegularExpression(pattern: "#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)")
            let allMatches = regex.matches(in: string, range: NSRange(location: 0, length: string.count))
            
            guard let match = allMatches.first else {
                preconditionFailure("Didn't match regex")
            }
            
            // Assuming everything's fine in terms of array indexing and Range matching...
            id = Int(string[Range(match.range(at: 1), in: string)!])!
            left = Int(string[Range(match.range(at: 2), in: string)!])!
            top = Int(string[Range(match.range(at: 3), in: string)!])!
            width = Int(string[Range(match.range(at: 4), in: string)!])!
            height = Int(string[Range(match.range(at: 5), in: string)!])!
        }
    }
    
    struct Inch {
        var claimIds: [Int]
        
        init() {
            claimIds = []
        }
    }
    
    static var fabricWithClaims: [[Inch]] {
        // Make a 2D array holding the fabric inches, and each one will store any ids that have claimed it
        
        let fabricSize = 1000
        var fabric: [[Inch]] = []
        
        for xInch in 0..<fabricSize {
            fabric.insert([], at: xInch)
            for yInch in 0..<fabricSize {
                fabric[xInch].insert(Inch(), at: yInch)
            }
        }
        
        // Map the claims on to the fabric grid
        for claim in claims {
            let xStart = claim.left
            let xEnd = xStart + claim.width
            
            let yStart = claim.top
            let yEnd = yStart + claim.height
            
            for xPos in xStart..<xEnd {
                for yPos in yStart..<yEnd {
                    fabric[xPos][yPos].claimIds.append(claim.id)
                }
            }
        }
        
        return fabric
    }
    
    static var claims: [Claim] {
        do {
            let lines = linesFromFile(path: "Day 03/Input")
            return try lines.map(Claim.init)
        } catch {
            print(error)
            preconditionFailure()
        }
    }
}
