//
//  Day7.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 09/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

struct Day7 {
    static func setupDict(from lines: [String]) -> [String: [String]] {
        var stepsAsDict: [String: [String]] = [:]
        
        lines.forEach {
            let capture = $0.capture(from: "Step ([A-Z]) must be finished before step ([A-Z]) can begin.")
            let step = capture[0]
            let doneBefore = capture[1]
            
            if let stepDictValue = stepsAsDict[step] {
                stepsAsDict[step] = stepDictValue.withAppended(element: doneBefore)
            } else {
                stepsAsDict[step] = [doneBefore]
            }
            
            if stepsAsDict[doneBefore] == nil {
                stepsAsDict[doneBefore] = []
            }
        }
        
        return stepsAsDict
    }
}
