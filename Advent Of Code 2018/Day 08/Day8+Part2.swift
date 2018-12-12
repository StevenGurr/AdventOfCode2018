//
//  Day8+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 09/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day8 {
    struct Part2: Solveable {
        let allNumbers: [Int]
        
        init() {
            let dataLine = linesFromFile(path: "Day 08/Input").first!
            allNumbers = dataLine.split(separator: " ").map { Int($0)! }
        }
        
        func go() -> String {
            var index = 0
            let rootNode = Day8.buildNode(from: &index, allNumbers: allNumbers)
            
            let result = getValueFor(node: rootNode)
            
            return String(result)
        }
        
        private func getValueFor(node: Node, value: Int = 0) -> Int {
            if node.childNodes.count == 0 {
                return node.metadataEntries.reduce(0, +)
            } else {
                
            }
        }
    }
}
