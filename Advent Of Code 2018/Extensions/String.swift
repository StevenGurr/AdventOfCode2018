//
//  String.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 05/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

// Borrowed from https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
extension String {
    subscript (index offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

extension String {
    func capture(from regexString: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regexString) else {
            preconditionFailure("Failed to build regex from: \(regexString)")
        }
        
        let allMatches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        
        guard let match = allMatches.first else {
            print("Failed to get any matches")
            return []
        }
        
        var result: [String] = []
        for index in 1..<match.numberOfRanges {
            guard let range = Range(match.range(at: index), in: self) else {
                print("Failed to find match at index \(index)")
                return []
            }
            
            result.append(String(self[range]))
        }
        
        return result
    }
}
