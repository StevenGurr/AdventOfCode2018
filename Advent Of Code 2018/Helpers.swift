//
//  Helpers.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 03/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

let projectRootPath = "/Users/steven/Advent Of Code/Advent Of Code 2018/Advent Of Code 2018"

func readFile(path: String) -> String {
    guard let data = FileManager.default.contents(atPath: "\(projectRootPath)/\(path)") else {
        preconditionFailure("Failed to open file")
    }
    guard let string = String(data: data, encoding: .utf8) else {
        preconditionFailure("Failed to parse data to string")
    }
    
    return string
}

func linesFromFile(path: String) -> [String] {
    return readFile(path: path).split(separator: "\n").map { String($0) }
}
