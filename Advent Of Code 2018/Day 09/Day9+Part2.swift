//
//  Day9+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 13/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day9 {
    struct Part2: Solveable {
        func go() -> String {
            let stateMachine = StateMachine(numberOfPlayers: 418, highestMarble: 7076900)
            stateMachine.go()
            
            return String(stateMachine.highestScore)
        }
    }
}
