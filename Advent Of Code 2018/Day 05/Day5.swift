//
//  Day5.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 05/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day5 {
    static func removeUnits(polymer: String) -> String {
        var index = 0
        var mutablePolymer = polymer
        repeat {
//            print("index: \(index) - length: \(mutablePolymer.count)")
            
            let char1 = mutablePolymer[index: index]
            let char2 = mutablePolymer[index: index+1]
            
            if sameUnitOppositePolarity(char1: char1, char2: char2) {
                let range = NSRange(location: index, length: 2)
                let stringRange = Range(range, in: polymer)!
                mutablePolymer.replaceSubrange(stringRange, with: "")
                
                if index > 0 {
                    index -= 1
                }
            } else {
                index += 1
            }
            
        } while index+1 < mutablePolymer.count
        
        return mutablePolymer
    }
    
    @inline(__always) private static func sameUnitOppositePolarity(char1: Character, char2: Character) -> Bool {
        // Check they're the same char first by making both lowerase
        guard Character(String(char1).lowercased()) == Character(String(char2).lowercased()) else {
            return false
        }
        
        // Now check they're not the same character, which should confirm different case
        return char1 != char2
    }
}
