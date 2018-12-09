//
//  Array.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 09/12/2018.
//  Copyright © 2018 Steven Gurr. All rights reserved.
//

import Foundation

extension Array {
    func withAppended(element: Element) -> Array {
        var newArray = self
        newArray.append(element)
        return newArray
    }
}
