//
//  Day9+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 12/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day9 {
    struct Part1: Solveable {
        func go() -> String {
            let stateMachine = StateMachine(numberOfPlayers: 418, highestMarble: 70769)
            stateMachine.go()
            
            return String(stateMachine.highestScore)
        }
    }
}
