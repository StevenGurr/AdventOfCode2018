//
//  Day14+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 28/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day14 {
    struct Part2: Solveable {
        var scoreboard = Scoreboard()
        
        func go() -> String {
            // Setup initial state
            let input = linesFromFile(path: "Day 14/Input").first!
            scoreboard.add(score: 3)
            scoreboard.add(score: 7)
            scoreboard.firstElfWorkingOn = scoreboard.firstRecipe
            scoreboard.secondElfWorkingOn = scoreboard.firstElfWorkingOn.next
            
            // Loop
            repeat {
                let newScores = Day14.getNewRecipes(newScore: scoreboard.newScore)
                for newScore in newScores {
                    scoreboard.add(score: newScore)
                    
                    if scoreboard.values.endsIn(input) {
                        break
                    }
                }
                
                scoreboard.moveFirstElfPointer()
                scoreboard.moveSecondElfPointer()
            } while !scoreboard.values.endsIn(input)
            
            return String(scoreboard.values.length-input.count)
        }
    }
}

fileprivate extension NSString {
    func endsIn(_ needle: String) -> Bool {
        guard self.length >= needle.count else {
            return false
        }
        
        let needleLength = needle.count
        let range = NSRange(location: self.length-needleLength, length: needleLength)
        return needle == self.substring(with: range)
    }
}
