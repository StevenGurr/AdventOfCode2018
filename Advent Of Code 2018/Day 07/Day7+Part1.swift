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
            
            var result: String = ""
            
            var stepsAsDict = setupDict(from: lines)
            
            // Now go!
            while let nextStep = nextStep(from: stepsAsDict) {
                result += nextStep
                stepsAsDict.removeValue(forKey: nextStep)
            }
            
            return result
        }
        
        private func setupDict(from lines: [String]) -> [String: [String]] {
            var stepsAsDict: [String: [String]] = [:]
            
            lines.forEach {
                let capture = $0.capture(from: "Step ([A-Z]) must be finished before step ([A-Z]) can begin.")
                let step = capture[0]
                let doneBefore = capture[1]
                
                if let stepDictValue = stepsAsDict[step] {
                    stepsAsDict[step] = stepDictValue.withAppended(element: doneBefore)
                } else {
                    stepsAsDict[step] = [doneBefore]
                }
                
                if stepsAsDict[doneBefore] == nil {
                    stepsAsDict[doneBefore] = []
                }
            }
            
            return stepsAsDict
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
