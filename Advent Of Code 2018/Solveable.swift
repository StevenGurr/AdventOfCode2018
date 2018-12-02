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
    /// Print the result, with optional assertion of correctness
    /// - Parameter expected: If set, the result is asserted to match this, else it's considered to have failed.
    func printResult(expected: String? = nil) {
        let prefixToStrip = CharacterSet(charactersIn: "Advent_Of_Code_2018.")
        let currentType = String(reflecting: self).trimmingCharacters(in: prefixToStrip)
        print(currentType, terminator: "")
        
        let result = go()
        if let expected = expected, result != expected {
            print(" - Failed! Expected '\(expected)', but got '\(result)'")
        } else {
            print(" - \(result)")
        }
    }
}
