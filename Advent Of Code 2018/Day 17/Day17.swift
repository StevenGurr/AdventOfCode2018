//
//  Day17.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

struct Day17 {
    struct Cell: Hashable {
        let x: Int
        let y: Int
        let type: CellType
        
        var dbgChar: Character {
            switch type {
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
    }
    
    enum CellType {
        case sand
        case clay
        case spring
        case waterPassed
        case settledWater
    }
}
