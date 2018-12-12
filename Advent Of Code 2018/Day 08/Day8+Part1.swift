//
//  Day8+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 09/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day8 {
    struct Part1: Solveable {
        let allNumbers: [Int]
        
        init() {
            let dataLine = linesFromFile(path: "Day 08/Input").first!
            allNumbers = dataLine.split(separator: " ").map { Int($0)! }
        }
        
        func go() -> String {
            var index = 0
            let rootNode = Day8.buildNode(from: &index, allNumbers: allNumbers)
            
            let result = sumAllMetadata(node: rootNode)
            
            return String(result)
        }
        
        private func sumAllMetadata(node: Node, value: Int = 0) -> Int {
            let thisNodeValue = node.metadataEntries.reduce(0, +)
            
            var childValues = 0
            for child in node.childNodes {
                childValues += sumAllMetadata(node: child)
            }
            
            return thisNodeValue + childValues
        }
    }
}
