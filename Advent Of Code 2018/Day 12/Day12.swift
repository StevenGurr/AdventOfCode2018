//
//  Day12.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 25/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day12 {
    struct SpreadRule {
        let twoBefore: Bool
        let oneBefore: Bool
        let current: Bool
        let oneAfter: Bool
        let twoAfter: Bool
        
        let affect: Bool
        
        init(raw: String) throws {
            let bits = raw.capture(from: "([.#]+) => ([.#])")
            
            let rule = bits[0]
            twoBefore = rule[index: 0] == "#"
            oneBefore = rule[index: 1] == "#"
            current = rule[index: 2] == "#"
            oneAfter = rule[index: 3] == "#"
            twoAfter = rule[index: 4] == "#"
            
            affect = bits[1] == "#"
        }
    }
}
