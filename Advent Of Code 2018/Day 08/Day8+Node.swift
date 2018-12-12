//
//  Day8+Node.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 12/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day8 {
    class Node {
        var childNodeQuantity: Int = 0
        var metadataQuantity: Int = 0
        var childNodes: [Node] = []
        var metadataEntries: [Int] = []
    }
}
