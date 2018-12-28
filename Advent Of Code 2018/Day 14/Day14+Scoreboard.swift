//
//  Day14+Scoreboard.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 28/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day14 {
    class Scoreboard {
        var firstRecipe: Recipe!
        var endRecipe: Recipe!
        var values = NSMutableString()
        var firstElfWorkingOn: Recipe!
        var secondElfWorkingOn: Recipe!
        
        func add(score: Int) {
            let recipe = Recipe(score: score)
            add(recipe: recipe)
        }
        
        private func add(recipe newRecipe: Recipe) {
            if firstRecipe == nil {
                firstRecipe = newRecipe
                firstRecipe.next = firstRecipe
                firstRecipe.previous = firstRecipe
            } else {
                let currentEnd = endRecipe!
                currentEnd.next = newRecipe
                newRecipe.previous = currentEnd
                newRecipe.next = firstRecipe
            }
            
            endRecipe = newRecipe
            values.append(String(newRecipe.score))
        }
        
        func moveFirstElfPointer() {
            moveElfPointer(elf: &firstElfWorkingOn)
        }
        
        func moveSecondElfPointer() {
            moveElfPointer(elf: &secondElfWorkingOn)
        }
        
        private func moveElfPointer(elf: inout Recipe) {
            let placesToMove = 1 + elf.score
            for _ in 0..<placesToMove {
                elf = elf.next
            }
        }
        
        var newScore: Int {
            return firstElfWorkingOn.score + secondElfWorkingOn.score
        }
    }
}
