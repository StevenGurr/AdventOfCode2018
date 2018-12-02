//
//  Day2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day2 {
    typealias CharDistribution = [Character: Int]
    
    static var input: String {
        guard let data = FileManager.default.contents(atPath: "\(projectRootPath)/Day 02/Input") else {
            preconditionFailure("Failed to open file")
        }
        guard let string = String(data: data, encoding: .utf8) else {
            preconditionFailure("Failed to parse data to string")
        }
        
        return string
    }
    
    static var lines: [String] {
        let lines = input.split(separator: "\n").map { String($0) }
        return lines
    }
}
