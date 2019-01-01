//
//  Day16+Instruction.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day16 {
    enum Instruction {
        case addr
        case addi
        case mulr
        case muli
        case banr
        case bani
        case borr
        case bori
        case setr
        case seti
        case gtir
        case gtri
        case gtrr
        case eqir
        case eqri
        case eqrr
        
        func perform(on registers: inout [Int], a: Int, b: Int, c: Int) { // swiftlint:disable:this cyclomatic_complexity
            switch self {
            case .addr:
                registers[c] = registers[a] + registers[b]
            case .addi:
                registers[c] = registers[a] + b
                
            case .mulr:
                registers[c] = registers[a] * registers[b]
            case .muli:
                registers[c] = registers[a] * b
                
            case .banr:
                registers[c] = registers[a] & registers[b]
            case .bani:
                registers[c] = registers[a] & b
                
            case .borr:
                registers[c] = registers[a] | registers[b]
            case .bori:
                registers[c] = registers[a] | b
                
            case .setr:
                registers[c] = registers[a]
            case .seti:
                registers[c] = a
                
            case .gtir:
                registers[c] = a > registers[b] ? 1 : 0
            case .gtri:
                registers[c] = registers[a] > b ? 1 : 0
            case .gtrr:
                registers[c] = registers[a] > registers[b] ? 1 : 0
                
            case .eqir:
                registers[c] = a == registers[b] ? 1 : 0
            case .eqri:
                registers[c] = registers[a] == b ? 1 : 0
            case .eqrr:
                registers[c] = registers[a] == registers[b] ? 1 : 0
            }
        }
    }
}
