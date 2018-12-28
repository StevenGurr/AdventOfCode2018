//
//  Day14+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 28/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day14 {
    class Part1: Solveable {
        var scoreboard = Scoreboard()
        
        func go() -> String {
            // Setup initial state
            let input = Int(linesFromFile(path: "Day 14/Input").first!)!
            scoreboard.add(score: 3)
            scoreboard.add(score: 7)
            scoreboard.firstElfWorkingOn = scoreboard.firstRecipe
            scoreboard.secondElfWorkingOn = scoreboard.firstElfWorkingOn.next
            
//            Day14.printScoreboard(scoreboard: scoreboard, firstElfWorkingOn: firstElfWorkingOn, secondElfWorkingOn: secondElfWorkingOn)
            
            // Loop
            repeat {
                let newScores = Day14.getNewRecipes(newScore: scoreboard.newScore)
                newScores.forEach {
                    scoreboard.add(score: $0)
                }
                
                scoreboard.moveFirstElfPointer()
                scoreboard.moveSecondElfPointer()
                
//                Day14.printScoreboard(scoreboard: scoreboard, firstElfWorkingOn: firstElfWorkingOn, secondElfWorkingOn: secondElfWorkingOn)
            } while scoreboard.values.length < input+10
            
            let result = scoreboard.values.substring(from: scoreboard.values.length-10)
            return result
        }
    }
}
