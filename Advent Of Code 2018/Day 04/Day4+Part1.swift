//
//  Day4+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 04/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day4 {
    struct Part1: Solveable {
        func go() -> String {
            let sleepRecords = Day4.getSleepRecords()
            
            // Count up how long each ID slept in total
            let sleepMinutesById = sleepRecords.reduce([:]) { (currentRecords, record) -> [Int: Int] in
                let thisRecordsSleepTime = (record.fellAsleepMinute..<record.wokeUpMinute).count
                
                if let currentMinutesAsleep = currentRecords[record.id] {
                    var newValues = currentRecords
                    newValues[record.id] = thisRecordsSleepTime + currentMinutesAsleep
                    return newValues
                } else {
                    var newValues = currentRecords
                    newValues[record.id] = thisRecordsSleepTime
                    return newValues
                }
            }
            
            // Force-unwrapped to save time...
            let guardIdThatSleptTheMost = sleepMinutesById.sorted(by: { $0.value > $1.value }).first!.key

            let sleepiestMinute = findSleepiestMinute(records: sleepRecords, guardIdThatSleptTheMost: guardIdThatSleptTheMost)
            
//            print("Sleepiest guard is \(guardIdThatSleptTheMost)")
//            print("Their sleepiest minute was \(sleepiestMinute)")
            return String(guardIdThatSleptTheMost * sleepiestMinute)
        }
        
        private func findSleepiestMinute(records: [SleepAccumulatorRecord], guardIdThatSleptTheMost: Int) -> Int {
            var minutes: [Int: Int] = [:]
            
            for record in records {
                guard record.id == guardIdThatSleptTheMost else {
                    continue
                }
                
                for minute in record.fellAsleepMinute..<record.wokeUpMinute {
                    if let currentMinuteCount = minutes[minute] {
                        minutes[minute] = currentMinuteCount + 1
                    } else {
                        minutes[minute] = 1
                    }
                }
            }
            return minutes.sorted(by: { $0.value > $1.value }).first!.key
        }
    }
}
