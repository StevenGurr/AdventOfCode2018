//
//  Day 1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 01/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day1 {
    static var input: String {
        guard let data = FileManager.default.contents(atPath: "\(projectRootPath)/Day 01/Input") else {
            preconditionFailure("Failed to open file")
        }
        guard let string = String(data: data, encoding: .utf8) else {
            preconditionFailure("Failed to parse data to string")
        }
        
        return string
    }
    
    static func lineToInt(line: String) -> Int {
        guard let int = Int(line) else {
            preconditionFailure("Could not convert \(line) to an int")
        }
        return int
    }
    
    static var values: [Int] {
        let lines = input.split(separator: "\n").map { String($0) }
        let values = lines.map { lineToInt(line: $0) }
        return values
    }
}
