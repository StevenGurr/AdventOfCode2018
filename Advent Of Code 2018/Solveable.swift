//
//  Solveable.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

protocol Solveable {
    func go() -> String
}

extension Solveable {
    func printResult() {
        let prefixToStrip = CharacterSet(charactersIn: "Advent_Of_Code_2018.")
        let currentType = String(reflecting: self).trimmingCharacters(in: prefixToStrip)
        print(currentType, terminator: "")
        print(" - \(go())")
    }
}
