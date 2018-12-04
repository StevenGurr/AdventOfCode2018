//
//  Day4+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 04/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day4 {
    struct Part1: Solveable {
        func go() -> String {
            let lines = linesFromFile(path: "Day 04/Input")
            guard let records = try? lines.map(Record.init) else {
                preconditionFailure("Failed to make record")
            }
            
            let sortedRecords = records.sorted(by: { $0.minute < $1.minute })
            
            print(sortedRecords)
            
            preconditionFailure()
        }
    }
}
