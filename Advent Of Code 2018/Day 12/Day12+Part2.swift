//
//  Day12+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 25/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day12 {
    class Part2: Solveable {
        let rules: [SpreadRule]
        var pots = Pots()
        /// Array of scores for each generation
        var preCalculated: [Int] = []
        
        init() {
            let lines = linesFromFile(path: "Day 12/Input")
            let setup = lines.first!.capture(from: "initial state: (.*)")
            
            let rulesSetup = lines[1..<lines.count]
            rules = rulesSetup.map {
                do {
                    return try SpreadRule(raw: $0)
                } catch {
                    print(error)
                    preconditionFailure()
                }
            }
            
            let potSetup = setup.first!
            potSetup.enumerated().forEach {
                let plant = $0.element == "#"
                pots.set(plant: plant, at: $0.offset)
            }
        }
        
        func go() -> String {
            let regularInterval = findPattern()
            
            let targetGeneration = 50000000000
            let precalculatedGenerations = preCalculated.count
            let difference = targetGeneration - precalculatedGenerations
            let offset = difference * regularInterval
            
            return String(preCalculated.last! + offset)
        }
        
        func findPattern() -> Int {
            let maxGenerations = 50000000000
//            print()
//            print("Starting: \(pots)")
            
            for _ in 0..<maxGenerations {
                let newPots = pots.getClone()
                
                for plantIndex in pots.lowestPotIndex-2...pots.highestPotIndex+2 {
                    let rule = pots.findRule(for: plantIndex, in: rules)
                    newPots.set(plant: rule.affect, at: plantIndex)
                }
                
                pots.updateFrom(pots: newPots)
                
                // Add to the precomputed array and check if we've hit the point where the value settles in to a pattern
                preCalculated.append(pots.score)
                if preCalculated.count > 4 {
                    let lastThree = Array(preCalculated[preCalculated.count-3..<preCalculated.count])
                    if lastThree[2] - lastThree[1] == lastThree[1] - lastThree[0] {
                        return lastThree[2] - lastThree[1]
                    }
                }
                
//                print("Generation \(generation) is \(pots.score)")
            }
            
            preconditionFailure("Should have found the pattern before now. :(")
        }
    }
}
