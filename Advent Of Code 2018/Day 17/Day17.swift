//
//  Day17.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

struct Day17 {
    enum CellType {
        case sand
        case clay
        case spring
        case waterPassed
        case settledWater
        
        var dbgChar: Character {
            switch self {
            case .sand:
                return "."
            case .clay:
                return "#"
            case .spring:
                return "+"
            case .waterPassed:
                return "|"
            case .settledWater:
                return "~"
            }
        }
        
        var isWater: Bool {
            switch self {
            case .sand,
                 .clay,
                 .spring:
                return false
            case .waterPassed,
                 .settledWater:
                return true
            }
        }
        
        var isClay: Bool {
            return self == .clay
        }
    }
}
