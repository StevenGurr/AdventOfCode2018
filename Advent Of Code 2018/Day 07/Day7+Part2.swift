//
//  Day7+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 09/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day7 {
    struct Part2: Solveable {
        // swiftlint:disable line_length
        let timePerStep = ["A": 61, "B": 62, "C": 63, "D": 64, "E": 65, "F": 66, "G": 67, "H": 68, "I": 69, "J": 70, "K": 71, "L": 72, "M": 73, "N": 74, "O": 75, "P": 76, "Q": 77, "R": 78, "S": 79, "T": 80, "U": 81, "V": 82, "W": 83, "X": 84, "Y": 85, "Z": 86 ]
        // swiftlint:enable line_length
        
        let maxPeopleWorking = 5
        
        func go() -> String {
            let lines = linesFromFile(path: "Day 07/Input")
            
            /// Steps in progress against their remaining time
            var stepsInProgress: [String: Int] = [:]
            var stepsAsDict = Day7.setupDict(from: lines)
            var timeTaken = -1 // Init to -1 as it increments before anything else happens
            var peopleWorking = maxPeopleWorking
            
            print(); print(); print()
            
            repeat {
                // Update the clock and tick the tasks
                timeTaken += 1
                
                for step in stepsInProgress.keys where stepsInProgress[step] == 0 {
                    print("\(timeTaken) - Step \(step) finished. Worker free to do something else now. \(peopleWorking) people left.")
                    peopleWorking += 1
                    stepsInProgress.removeValue(forKey: step)
                    stepsAsDict.removeValue(forKey: step)
                }
                
                while let nextStep = getNextStep(from: stepsAsDict, ignoring: stepsInProgress.keys.map { $0 }), peopleWorking > 0 {
                    stepsInProgress[nextStep] = timePerStep[nextStep]!
                    peopleWorking -= 1
                    
                    print("\(timeTaken) - Assigned step \(nextStep) to a worker which will take \(stepsInProgress[nextStep]!) seconds. \(peopleWorking) people left.")
                }
                
                stepsInProgress.forEach {
                    stepsInProgress[$0.key] = $0.value-1
                }
            } while stepsInProgress.count > 0 || getNextStep(from: stepsAsDict, ignoring: stepsInProgress.keys.map { $0 }) != nil
            
            return String(timeTaken)
        }
        
        func getNextStep(from stepsAsDict: [String: [String]], ignoring: [String]) -> String? {
            let allKeys = stepsAsDict.keys.map { $0 }
            let allValues = Set(stepsAsDict.values.flatMap({ $0 }))
            
            var validStartKeys: [String] = []
            
            for key in allKeys {
                if allValues.contains(key) == false && ignoring.contains(key) == false {
                    validStartKeys.append(key)
                }
            }
            
            return validStartKeys.sorted(by: { $0 < $1 }).first
        }
    }
}
