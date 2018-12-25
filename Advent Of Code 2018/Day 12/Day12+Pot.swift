//
//  Day12+Pot.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 25/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day12 {
    typealias Index = Int
    typealias Plant = Bool
    
    class Pots: CustomDebugStringConvertible {
        var plants: [Index: Plant]
        
        var lowestPotIndex: Int {
            return plants.keys.reduce(Int.max) { min($0, $1) }
        }
        
        var highestPotIndex: Int {
            return plants.keys.reduce(Int.min) { max($0, $1) }
        }
        
        var score: Int {
            return indexesOfPotsWithPlants.reduce(0, +)
        }
        
        init() {
            plants = [:]
        }
        
        func set(plant: Plant, at index: Int) {
            plants[index] = plant
        }
        
        func hasPlant(at index: Int) -> Bool {
            return plants[index] ?? false
        }
        
        var indexesOfPotsWithPlants: [Index] {
            return plants.filter({ $0.value == true }).keys.map { $0 }
        }
        
        var debugDescription: String {
            let sortedPlants = plants.sorted(by: { $0.key < $1.key })
            return String(sortedPlants.map { $0.value ? "#" : "." })
        }
        
        func getClone() -> Pots {
            let newPots = Pots()
            newPots.plants = plants
            return newPots
        }
        
        func updateFrom(pots: Pots) {
            self.plants = pots.plants
        }
        
        func findRule(for index: Int, in rules: [SpreadRule]) -> SpreadRule {
            let twoBefore = hasPlant(at: index-2)
            let oneBefore = hasPlant(at: index-1)
            let current = hasPlant(at: index)
            let oneAfter = hasPlant(at: index+1)
            let twoAfter = hasPlant(at: index+2)
            
            for rule in rules {
                if rule.twoBefore == twoBefore &&
                    rule.oneBefore == oneBefore &&
                    rule.current == current &&
                    rule.oneAfter == oneAfter &&
                    rule.twoAfter == twoAfter {
                    return rule
                }
            }
            
            preconditionFailure("Could not find a rule. Should never happen.")
        }
    }
}

extension Day12.Pots: Equatable {
    static func == (lhs: Day12.Pots, rhs: Day12.Pots) -> Bool {
        return lhs.plants == rhs.plants
    }
}
