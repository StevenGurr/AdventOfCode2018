//
//  Day4.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 04/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day4 {
    struct SleepAccumulatorRecord {
        let id: Int
        let fellAsleepMinute: Int
        let wokeUpMinute: Int
    }
    
    static func getSleepRecords() -> [SleepAccumulatorRecord] {
        let lines = linesFromFile(path: "Day 04/Input")
        guard let records = try? lines.map(Record.init).sorted() else {
            preconditionFailure("Failed to make record")
        }
        
        var sleepAccumulatorRecords: [SleepAccumulatorRecord] = []
        
        var currentGuardId = 0
        var fellAsleepMinute = 0
        var wokeUpMinute = 0
        for record in records {
            switch record.event {
            case let .beginsShift(id):
                currentGuardId = id
                
            case .fallsAsleep:
                fellAsleepMinute = record.minute
                
            case .wakesUp:
                wokeUpMinute = record.minute
                let newRecord = SleepAccumulatorRecord(id: currentGuardId, fellAsleepMinute: fellAsleepMinute, wokeUpMinute: wokeUpMinute)
                sleepAccumulatorRecords.append(newRecord)
            }
        }
        
        return sleepAccumulatorRecords
    }
    
}
