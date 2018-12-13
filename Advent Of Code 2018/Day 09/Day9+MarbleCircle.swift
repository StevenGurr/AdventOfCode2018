//
//  Day9+MarbleCircle.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 12/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day9 {
    class MarbleCircle {
        var firstMarble: Marble
        var lastMarble: Marble
        
        init(marble: Marble) {
            firstMarble = marble
            lastMarble = marble
        }
        
//        func insert(marble newMarble: Marble, after index: Int) {
//            var marble = firstMarble
//            for _ in 0..<index {
//                marble = marble.next
//            }
//            insert(marble: newMarble, after: marble)
//        }
//        
        func insert(marble: Marble, after: Marble) {
            marble.next = after.next
            marble.previous = after
            
            after.next = marble
            marble.next.previous = marble
        }
        
        func remove(marble: Marble) {
            marble.previous.next = marble.next
            marble.next.previous = marble.previous
        }
    }
}

extension Day9.MarbleCircle: CustomDebugStringConvertible {
    var debugDescription: String {
        var result = ""
        var marble = firstMarble
        repeat {
            result += String(marble.score)
            result += ", "
            marble = marble.next
        } while marble !== firstMarble
        
        return result
    }
    
    func debugPrintWith(current: Day9.Marble) -> String {
        var result = ""
        var marble = firstMarble
        repeat {
            if marble.score == current.score {
                result += "("
            }
            result += String(marble.score)
            if marble.score == current.score {
                result += ")"
            }

            result += ", "
            marble = marble.next
        } while marble !== firstMarble
        
        return result
    }
}
