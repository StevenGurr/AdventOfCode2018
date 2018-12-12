//
//  Day8.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 09/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day8 {
    static func buildNode(from index: inout Int, allNumbers: [Int]) -> Node {
        let node = Node()
        node.childNodeQuantity = allNumbers[index]
        index += 1
        
        node.metadataQuantity = allNumbers[index]
        index += 1
        
        for _ in 0..<node.childNodeQuantity {
            let childNode = buildNode(from: &index, allNumbers: allNumbers)
            node.childNodes.append(childNode)
        }
        
        for _ in 0..<node.metadataQuantity {
            node.metadataEntries.append(allNumbers[index])
            index += 1
        }
        
        return node
    }
}
