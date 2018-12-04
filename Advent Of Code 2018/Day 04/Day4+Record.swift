//
//  Day4+Record.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 04/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day4 {
    struct Record {
        enum Event {
            case fallsAsleep
            case wakesUp
            case beginsShift(id: Int)
            
            init(event: String) throws {
                if event == "falls asleep" {
                    self = .fallsAsleep
                } else if event == "wakes up" {
                    self = .wakesUp
                } else {
                    let regex = try NSRegularExpression(pattern: "Guard #(\\d+) begins shift")
                    let allMatches = regex.matches(in: event, range: NSRange(location: 0, length: event.count))
                    
                    guard let match = allMatches.first else {
                        preconditionFailure("Didn't match regex")
                    }
                    
                    guard let range = Range(match.range(at: 1), in: event) else {
                        preconditionFailure("Invalid guard ID")
                    }
                    let id = Int(event[range])!
                    self = .beginsShift(id: id)
                }
            }
        }
        
        let year: Int
        let month: Int
        let day: Int
        let hour: Int
        let minute: Int
        let event: Event
        
        init(record: String) throws {
            let regex = try NSRegularExpression(pattern: "\\[(\\d{4})-(\\d{2})-(\\d{2}) (\\d{2}):(\\d{2})] (.*)$")
            let allMatches = regex.matches(in: record, range: NSRange(location: 0, length: record.count))
            
            guard let match = allMatches.first else {
                preconditionFailure("Didn't match regex")
            }
            
            // Assuming everything's fine in terms of array indexing and Range matching...
            // Force unwrapping danger ahead!
            year = Int(record[Range(match.range(at: 1), in: record)!])!
            month = Int(record[Range(match.range(at: 2), in: record)!])!
            day = Int(record[Range(match.range(at: 3), in: record)!])!
            hour = Int(record[Range(match.range(at: 4), in: record)!])!
            minute = Int(record[Range(match.range(at: 5), in: record)!])!
            event = try Event(event: String(record[Range(match.range(at: 6), in: record)!]))
        }
    }
}

extension Day4.Record: Comparable {
    static func < (lhs: Day4.Record, rhs: Day4.Record) -> Bool {
        if lhs.year < rhs.year {
            return true
        } else if lhs.year > rhs.year {
            return false
        }
        
        if lhs.month < rhs.month {
            return true
        } else if lhs.month > rhs.month {
            return false
        }
        
        if lhs.day < rhs.day {
            return true
        } else if lhs.day > rhs.day {
            return false
        }
        
        if lhs.hour < rhs.hour {
            return true
        } else if lhs.hour > rhs.hour {
            return false
        }
        
        if lhs.minute < rhs.minute {
            return true
        } else if lhs.minute > rhs.minute {
            return false
        }
        
        return false
    }
    
    static func == (lhs: Day4.Record, rhs: Day4.Record) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day && lhs.hour == rhs.hour && lhs.minute == rhs.minute
    }
}
