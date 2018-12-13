//
//  Day9+Marble.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 12/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day9 {
    class Marble {
        let score: Int
        var previous: Marble! // Would never do this force-unwrap in production code!
        var next: Marble! // Would never do this force-unwrap in production code!
        
        init(score: Int) {
            self.score = score
        }
    }
}

extension Day9.Marble: CustomDebugStringConvertible {
    var debugDescription: String {
        return "Score: \(score), previousScore: \(previous.score), nextScore: \(next.score)"
    }
}
