//
//  Day9+StateMachine.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 13/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day9 {
    class StateMachine {
        let numberOfPlayers: Int
        let highestMarble: Int
        lazy var playersScores: [Int] = (0..<numberOfPlayers).map { _ in 0 }
        let marbleCircle: MarbleCircle
        
        var highestScore: Int {
            return playersScores.reduce(0) { max($0, $1) }
        }
        
        init(numberOfPlayers: Int, highestMarble: Int) {
            self.numberOfPlayers = numberOfPlayers
            self.highestMarble = highestMarble
            
            let firstMarble = Marble(score: 0)
            firstMarble.previous = firstMarble
            firstMarble.next = firstMarble
            self.marbleCircle = MarbleCircle(marble: firstMarble)
        }
        
        func go() {
            var currentMarble = marbleCircle.firstMarble
            
            var marbleScore = 0
            var playerNumber = -1 // Incremented straight away
            
            repeat {
                marbleScore += 1
                playerNumber = (playerNumber + 1) % numberOfPlayers
                
                let marble = Marble(score: marbleScore)
                if marbleScore % 23 == 0 {
                    handle23(newMarble: marble, currentMarble: &currentMarble, playerNumber: playerNumber)
                } else {
                    marbleCircle.insert(marble: marble, after: currentMarble.next)
                    currentMarble = marble
                }
                //                print("[\(playerNumber+1)] \(marbleCircle.debugPrintWith(current: currentMarble))")
            } while marbleScore < highestMarble
        }
        
        private func handle23(newMarble: Marble, currentMarble: inout Marble, playerNumber: Int) {
            playersScores[playerNumber] += newMarble.score
            
            var marbleToRemove = currentMarble
            for _ in (0..<7) { marbleToRemove = marbleToRemove.previous }
            currentMarble = marbleToRemove.next
            marbleCircle.remove(marble: marbleToRemove)
            playersScores[playerNumber] += marbleToRemove.score
        }
    }
}
