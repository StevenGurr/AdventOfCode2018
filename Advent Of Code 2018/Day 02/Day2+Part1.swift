//
//  Day2+Part1.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 02/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Day2 {
    struct Part1: Solveable {
        func go() -> String {
            var twoMatches = 0
            var threeMathes = 0
            
            for line in linesFromFile(path: "Day 02/Input") {
                let frequency = lineToFrequency(line: line)
                
                if lettersMatch(chars: frequency, matchCount: 2) {
                    twoMatches += 1
                }
                
                if lettersMatch(chars: frequency, matchCount: 3) {
                    threeMathes += 1
                }
            }
            
            return String(twoMatches * threeMathes)
        }
        
        private func lineToFrequency(line: String) -> CharDistribution {
            let charsArray = Array(line)
            
            return charsArray.reduce([:]) {
                var charsDict = $0
                if let currentCount = charsDict[$1] {
                    charsDict[$1] = currentCount + 1
                } else {
                    charsDict[$1] = 1
                }
                
                return charsDict
            }
        }
        
        func lettersMatch(chars: CharDistribution, matchCount: Int) -> Bool {
            for charCount in chars where charCount.value == matchCount {
                return true
            }
            
            return false
        }
    }
}
