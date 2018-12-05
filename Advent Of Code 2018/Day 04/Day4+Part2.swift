//
//  Day4+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 05/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day4 {
    struct IdAndMinute: Hashable {
        let id: Int
        let minute: Int
    }
    
    struct Part2: Solveable {
        func go() -> String {
            let sleepRecords = Day4.getSleepRecords()
            var idAndMinuteFrequency: [IdAndMinute: Int] = [:]
            
            for record in sleepRecords {
                for minute in record.fellAsleepMinute..<record.wokeUpMinute {
                    let idAndMinute = IdAndMinute(id: record.id, minute: minute)
                    if let frequency = idAndMinuteFrequency[idAndMinute] {
                        idAndMinuteFrequency[idAndMinute] = frequency + 1
                    } else {
                        idAndMinuteFrequency[idAndMinute] = 1
                    }
                }
            }
            
            let mostAsleepGuardAndMinute = idAndMinuteFrequency.sorted(by: { $0.value > $1.value }).first!
            
            let guardId = mostAsleepGuardAndMinute.key.id
            let minute = mostAsleepGuardAndMinute.key.minute
            
//            print(guardId)
//            print(minute)
            
            return String(guardId * minute)
        }
    }
}
