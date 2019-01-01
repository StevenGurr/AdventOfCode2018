//
//  Day16+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day16 {
    struct Part1: Solveable {
        func go() -> String {
            let samples = readFile(path: "Day 16/Input1").components(separatedBy: "\n\n")
            
            var result = 0
            for sample in samples {
                let values = sample.capture(from: "Before: +\\[(\\d+), (\\d+), (\\d+), (\\d+)]\\n(\\d+) (\\d+) (\\d+) (\\d+)\\nAfter: +\\[(\\d+), (\\d+), (\\d+), (\\d+)\\]") // swiftlint:disable:this line_length
                
                let beforeRegisters = [Int(values[0])!, Int(values[1])!, Int(values[2])!, Int(values[3])!]
//                let ignored = values[4]
                let a = Int(values[5])!
                let b = Int(values[6])!
                let c = Int(values[7])!
                let afterRegisters = [Int(values[8])!, Int(values[9])!, Int(values[10])!, Int(values[11])!]
                
                let matches = Day16.instructions.reduce(0) { counter, instruction in
                    var mutableRegisters = beforeRegisters
                    instruction.perform(on: &mutableRegisters, a: a, b: b, c: c)
                    if mutableRegisters == afterRegisters {
//                        print("match on \(instruction)")
                        return counter + 1
                    } else {
                        return counter
                    }
                }
                
                if matches >= 3 {
                    result += 1
                }
            }
            
            return String(result)
        }
    }
}
