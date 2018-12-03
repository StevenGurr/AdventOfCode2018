//
//  Day3+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 03/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day3 {
    struct Part1: Solveable {
        
        func go() -> String {
            // Now count how many have two or more clais per inch
            let flattened = Day3.fabricWithClaims.flatMap({ $0 })
            let result = flattened.filter({
                $0.claimIds.count > 1
            }).count
            
            return (String(result))
        }
    }
}
