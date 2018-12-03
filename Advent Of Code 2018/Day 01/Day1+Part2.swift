//
//  Day1+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day1 {
    
    /// Note: There's a huge cost of memory churn and slow performance in exchange for immutability. This takes a long time to run.
    struct Part2: Solveable {
        func go() -> String {
            
            let values = linesFromFile(path: "Day 01/Input").map(lineToInt)
            var runResults = tryValueSet(frequency: 0, seenFrequencies: [], values: values)
            
            while runResults.firstMatch == nil {
//                print("running again - set size is \(runResults.seenFrequencies.count)")
                runResults = tryValueSet(frequency: runResults.frequency, seenFrequencies: runResults.seenFrequencies, values: values)
            }
            
            guard let firstMatch = runResults.firstMatch else {
                preconditionFailure("Should never get here if loop worked")
            }
            
            return String(firstMatch)
        }
        
        private func tryValueSet(frequency immutableFrequency: Int,
                                 seenFrequencies immutableSeenFrequencies: Set<Int>,
                                 values: [Int]) -> (firstMatch: Int?, seenFrequencies: Set<Int>, frequency: Int) {
            var frequency = immutableFrequency
            var seenFrequencies = immutableSeenFrequencies
            
            for value in values {
                if gotMatch(seenFrequencies: seenFrequencies, newFrequency: frequency) {
                    return (firstMatch: frequency, seenFrequencies: seenFrequencies, frequency: frequency)
                } else {
                    seenFrequencies = newFrequency(seenFrequencies: seenFrequencies, newFrequency: frequency)
                }
                
                frequency += value
            }
            
            return (firstMatch: nil, seenFrequencies: seenFrequencies, frequency: frequency)
        }
        
        private func gotMatch(seenFrequencies: Set<Int>, newFrequency: Int) -> Bool {
            return seenFrequencies.contains(newFrequency)
        }
        
        private func newFrequency(seenFrequencies: Set<Int>, newFrequency: Int) -> Set<Int> {
            let newSet = Set<Int>.init([newFrequency])
            return seenFrequencies.union(newSet)
        }
    }
}
