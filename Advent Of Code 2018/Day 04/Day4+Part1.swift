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
            let lines = linesFromFile(path: "Day 04/Input")
            guard let records = try? lines.map(Record.init) else {
                preconditionFailure("Failed to make record")
            }
            
            let sortedRecords = records.sorted()
            
            let sleepRecords = getSleepRecords(records: sortedRecords)
            
            // Force-unwrapped to save time...
            let guardIdThatSleptTheMost = sleepRecords.sorted(by: { $0.value > $1.value }).first!.key
            
            let sleepiestMinute = findSleepiestMinute(records: sortedRecords, guardIdThatSleptTheMost: guardIdThatSleptTheMost)
            
//            print("Sleepiest guard is \(guardIdThatSleptTheMost)")
//            print("Their sleepiest minute was \(sleepiestMinute)")
            return String(guardIdThatSleptTheMost * sleepiestMinute)
        }
        
        func getSleepRecords(records: [Record]) -> SleepAccumulatorRecord {
            var sleepRecords = SleepAccumulatorRecord()
            
            var currentGuardId = 0
            var fellAsleepMinute = 0
            for record in records {
                switch record.event {
                case let .beginsShift(id):
                    currentGuardId = id
                    
                case .fallsAsleep:
                    fellAsleepMinute = record.minute
                    
                case .wakesUp:
                    let minutesAsleep = record.minute - fellAsleepMinute
                    if let sleepMinutesSoFar = sleepRecords[currentGuardId] {
                        sleepRecords[currentGuardId] = sleepMinutesSoFar + minutesAsleep
                    } else {
                        sleepRecords[currentGuardId] = minutesAsleep
                    }
                }
            }
            
            return sleepRecords
        }
        
        private func findSleepiestMinute(records: [Record], guardIdThatSleptTheMost: Int) -> Int {
            var minutes: [Int: Int] = [:]
            
            var currentGuardId = 0
            var fellAsleepMinute = 0
            for record in records {
                switch record.event {
                case let .beginsShift(id):
                    currentGuardId = id
                    
                case .fallsAsleep:
                    fellAsleepMinute = record.minute
                    
                case .wakesUp:
                    guard currentGuardId == guardIdThatSleptTheMost else {
                        break
                    }
                    for minute in fellAsleepMinute..<record.minute {
                        if let minutesCountedSofar = minutes[minute] {
                            minutes[minute] = minutesCountedSofar+1
                        } else {
                            minutes[minute] = 1
                        }
                    }
                }
            }
            
            let sortedMinutes = minutes.sorted(by: { $0.value > $1.value })
            
            // Force unwrapping! :o
            return sortedMinutes.first!.key
        }
    }
}
