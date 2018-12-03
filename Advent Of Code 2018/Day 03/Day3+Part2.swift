//
//  Day3+Part2.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 03/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day3 {
    struct Part2: Solveable {
        func go() -> String {
            let flattenedClaims = Day3.fabricWithClaims.flatMap({ $0 })
            let claims = Day3.claims
            
            for claim in claims {
                // For each claim, see if it ever overlaps with another claim
                // Find which inches this claim has claimed
                let inchesForThisClaim = flattenedClaims.filter({ $0.claimIds.contains(claim.id) })
                
                let sharesInch = inchesForThisClaim.contains(where: { $0.claimIds.count > 1 })
                
                // If there's no sharing of any inches, then we've got our match!
                if sharesInch == false {
                    return String(claim.id)
                }
            }
            
            preconditionFailure("Must have returned in the loop")
        }
    }
}
