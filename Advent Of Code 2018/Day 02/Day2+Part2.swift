//
//  Day2+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day2 {
    struct Part2: Solveable {
        func go() -> String {
            let lines = linesFromFile(path: "Day 02/Input")
            for line1 in lines {
//                print("Loop1")
                for line2 in lines {
//                    print("\tLoop2")
                    let indexesOfDifferentChars = getIndexesOfDifferentChars(line1: line1, line2: line2)
                    if indexesOfDifferentChars.count == 1, let index = indexesOfDifferentChars.first {
                        return get(string: line1, withoutCharacterAt: index)
                    }
                }
            }
            
            preconditionFailure("Must always have returned by now")
        }
        
        private func getIndexesOfDifferentChars(line1: String, line2: String) -> [Int] {
            guard line1.count == line2.count else {
                preconditionFailure("Strings need to be the same length")
            }
            
            var differentIndexes: [Int] = []
            
            for (index, (char1, char2)) in zip(line1, line2).enumerated() where char1 != char2 {
                differentIndexes.append(index)
            }
            
            return differentIndexes
        }
        
        private func get(string: String, withoutCharacterAt indexToRemove: Int) -> String {
            var result = ""
            for (index, char) in string.enumerated() where index != indexToRemove {
                result.append(char)
            }
            
            return result
        }
    }
}
