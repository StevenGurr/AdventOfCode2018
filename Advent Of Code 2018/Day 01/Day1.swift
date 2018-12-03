//
//  Day 1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day1 {
    static func lineToInt(line: String) -> Int {
        guard let int = Int(line) else {
            preconditionFailure("Could not convert \(line) to an int")
        }
        return int
    }
}
