//
//  Day10.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 14/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day10 {
    struct SkySize: Comparable {
        let width: Int
        let height: Int
        
        static func < (lhs: Day10.SkySize, rhs: Day10.SkySize) -> Bool {
            return lhs.width < rhs.width && lhs.height < rhs.height
        }
    }
}
