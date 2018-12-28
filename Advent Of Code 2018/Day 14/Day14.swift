//
//  Day14.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 28/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day14 {
    class Recipe: CustomDebugStringConvertible {
        let score: Int
        var previous: Recipe!
        var next: Recipe!
        
        init(score: Int) {
            self.score = score
        }
        
        var debugDescription: String {
            return "\(score)"
        }
    }
    
    static func getNewRecipes(newScore: Int) -> [Int] {
        // Special case that the loop won't run if the score is 0
        guard newScore != 0 else {
            return [newScore]
        }
        
        var mutableNewScore = newScore
        var newScores: [Int] = []
        
        // Insert each digit at the sart making the order reversed
        while mutableNewScore > 0 {
            newScores.insert(mutableNewScore % 10, at: 0)
            mutableNewScore /= 10
        }
        
        return newScores
    }
    
    // MARK: - Helper
    static func printScoreboard(scoreboard: Scoreboard, firstElfWorkingOn: Recipe, secondElfWorkingOn: Recipe) {
        guard scoreboard.firstRecipe !== scoreboard.endRecipe else {
            print(scoreboard.firstRecipe.score)
            return
        }
        
        var recipe: Recipe! = scoreboard.firstRecipe
        repeat {
            let leadingChar = firstElfWorkingOn === recipe ? "(" : secondElfWorkingOn === recipe ? "[" : " "
            let trailingChar = firstElfWorkingOn === recipe ? ")" : secondElfWorkingOn === recipe ? "]" : " "
            print(leadingChar, terminator: "")
            print(recipe.score, terminator: "")
            print(trailingChar, terminator: "")
            recipe = recipe!.next
        } while recipe !== scoreboard.firstRecipe
        print()
    }
}
