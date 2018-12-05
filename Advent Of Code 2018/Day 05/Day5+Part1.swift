//
//  Day5+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 05/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day5 {
    struct Part1: Solveable {
        func go() -> String {
            
            let line = linesFromFile(path: "Day 05/Input").first!
            
            var didReact = false
            var polymer = line
            repeat {
                let result = firstPairRemoved(polymer: polymer)
                didReact = result.didReact
                polymer = result.polymer
                
                print(polymer.count)
            } while didReact
            
            return String(polymer.count)
        }
        
        func firstPairRemoved(polymer: String) -> (polymer: String, didReact: Bool) {
            for (index, char) in polymer.enumerated() {
                guard index+1 < polymer.count else {
                    return (polymer: polymer, didReact: false)
                }
                
                let nextChar = polymer[index: index+1]
                if sameUnitOppositePolarity(char1: char, char2: nextChar) {
                    let range = NSRange(location: index, length: 2)
                    let newPolymer = NSString(string: polymer).replacingCharacters(in: range, with: "")
                    return (polymer: newPolymer, didReact: true)
                }
            }
            
            return (polymer: polymer, didReact: false)
        }
        
        func sameUnitOppositePolarity(char1: Character, char2: Character) -> Bool {
            // Check they're the same char first by making both lowerase
            guard Character(String(char1).lowercased()) == Character(String(char2).lowercased()) else {
                return false
            }
            
            // Now check they're not the same character, which should confirm different case
            return char1 != char2
        }
    }
}
