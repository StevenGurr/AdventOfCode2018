//
//  Day16+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day16 {
    class Part2: Solveable {
        var opcodes: [Int: Instruction] = [:]
        
        func go() -> String {
            let samples = readFile(path: "Day 16/Input1").components(separatedBy: "\n\n")
            
            solveOpCodes(samples: samples)
            assert(opcodes.count == 16)
            
            let instructionStrings = linesFromFile(path: "Day 16/Input2")
            let instructions = instructionStrings.map { $0.split(separator: " ").map { Int($0)! } }
            var registers = [0, 0, 0, 0]
            
            instructions.forEach { instruction in
                let opcode = opcodes[instruction[0]]!
                opcode.perform(on: &registers, a: instruction[1], b: instruction[2], c: instruction[3])
            }
            
            return String(registers[0])
        }
        
        private func solveOpCodes(samples: [String]) {
            var mutableInstructions = Day16.instructions
            
            while mutableInstructions.count > 0 {
                print("Got to solve \(mutableInstructions.count)")
                for sample in samples {
                    let values = sample.capture(from: "Before: +\\[(\\d+), (\\d+), (\\d+), (\\d+)]\\n(\\d+) (\\d+) (\\d+) (\\d+)\\nAfter: +\\[(\\d+), (\\d+), (\\d+), (\\d+)\\]") // swiftlint:disable:this line_length
                    
                    let beforeRegisters = [Int(values[0])!, Int(values[1])!, Int(values[2])!, Int(values[3])!]
                    let instruction = Int(values[4])!
                    let a = Int(values[5])!
                    let b = Int(values[6])!
                    let c = Int(values[7])!
                    let afterRegisters = [Int(values[8])!, Int(values[9])!, Int(values[10])!, Int(values[11])!]
                    
                    let matchedInstructions: [Instruction] = mutableInstructions.reduce([]) { instructions, instruction in
                        var mutableRegisters = beforeRegisters
                        instruction.perform(on: &mutableRegisters, a: a, b: b, c: c)
                        if mutableRegisters == afterRegisters {
//                            print("match on \(instruction)")
                            return instructions.withAppended(element: instruction)
                        } else {
                            return instructions
                        }
                    }
                    
                    if matchedInstructions.count == 1 {
                        print("Sussed \(matchedInstructions[0])")
                        opcodes[instruction] = matchedInstructions[0]
                        mutableInstructions.remove(matchedInstructions[0])
                    }
                }
            }
        }
    }
}
