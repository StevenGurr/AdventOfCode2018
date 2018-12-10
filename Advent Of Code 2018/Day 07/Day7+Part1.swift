//
//  Day7+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 09/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day7 {
    struct Part1: Solveable {
        func go() -> String {
            let lines = linesFromFile(path: "Day 07/Input")
            
            var stepsAsDict = Day7.setupDict(from: lines)
            var result: String = ""

            // Now go!
            while let nextStep = nextStep(from: stepsAsDict) {
                result += nextStep
                stepsAsDict.removeValue(forKey: nextStep)
            }
            
            return result
        }
        
        func nextStep(from stepsAsDict: [String: [String]]) -> String? {
            let allKeys = stepsAsDict.keys.map { $0 }
            let allValues = Set(stepsAsDict.values.flatMap({ $0 }))
            
            var validStartKeys: [String] = []
            
            for key in allKeys {
                if allValues.contains(key) == false {
                    validStartKeys.append(key)
                }
            }
            
            return validStartKeys.sorted(by: { $0 < $1 }).first
        }
    }
}
