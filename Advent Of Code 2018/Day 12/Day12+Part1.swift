//
//  Day12+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 25/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day12 {
    struct Part1: Solveable {
        let rules: [SpreadRule]
        var pots = Pots()
        
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
            let maxGenerations = 20
            print()
            
            print("Starting: \(pots)")

            for generation in 0..<maxGenerations {
                let newPots = pots.getClone()
                
                for plantIndex in pots.lowestPotIndex-2...pots.highestPotIndex+2 {
                    let rule = pots.findRule(for: plantIndex, in: rules)
                    newPots.set(plant: rule.affect, at: plantIndex)
                }
                
                pots.updateFrom(pots: newPots)
                print("\(generation): \(pots)")
            }
            
            let indexesWithPlants = pots.indexesOfPotsWithPlants
            
            return String(indexesWithPlants.reduce(0, +))
        }
    }
}
