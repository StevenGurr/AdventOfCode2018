//
//  Day1+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day1 {
    struct Part1: Solveable {
        func go() -> String {
            let reduced = Day1.values.reduce(0, { $0 + $1 })
            
            return String(reduced)
        }
    }
}
