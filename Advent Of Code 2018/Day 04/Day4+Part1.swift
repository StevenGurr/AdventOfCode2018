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
            
            preconditionFailure()
        }
        
        func getSleepRecords(records: [Record]) -> SleepRecord {
            var sleepRecords = SleepRecord()
            
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
    }
}
