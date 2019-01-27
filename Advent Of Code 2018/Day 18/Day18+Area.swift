//
//  Day18+Area.swift
//  Advent Of Code 2018
//
//  Created by Steven Gurr on 27/01/2019.
//  Copyright © 2019 Steven Gurr. All rights reserved.
//

import Foundation

extension Day18 {
    enum Acre {
        case open
        case trees
        case lumberyard
        
        var dbgChar: Character {
            switch self {
            case .open:
                return "."
            case .trees:
                return "|"
            case .lumberyard:
                return "#"
            }
        }
    }
    
    typealias LumberCollection = [[Acre]]
    
    class Area {
        var area: LumberCollection = []
        var mutationHistory: [LumberCollection] = []
        var repititionStartOffset: Int?
        
        init(lines: [String]) {
            for line in lines {
                let lineAsEnums: [Acre] = line.map {
                    if $0 == "." {
                        return .open
                    } else if $0 == "|" {
                        return .trees
                    } else if $0 == "#" {
                        return .lumberyard
                    } else {
                        preconditionFailure()
                    }
                }
                
                area.append(lineAsEnums)
            }
        }
        
        func tick() {
            if repititionStartOffset == nil {
                for historyItem in mutationHistory.enumerated() {
                    if historyItem.element == area {
                        repititionStartOffset = historyItem.offset
                        return
                    }
                }
                mutationHistory.append(area)
            }
            
            var mutatingArea = area
            
            for y in 0..<area.count {
                for x in 0..<area[y].count {
                    let surrounding = getSurrounding(y: y, x: x)
                    
                    switch area[y][x] {
                    case .open:
                        mutatingArea[y][x] = modifyOpen(with: surrounding)
                    case .trees:
                        mutatingArea[y][x] = modifyTrees(with: surrounding)
                    case .lumberyard:
                        mutatingArea[y][x] = modifyLumberyard(with: surrounding)
                    }
                }
            }
            
            area = mutatingArea
        }
        
        func acresWith(type: Acre) -> Int {
            return acresWith(type: type, in: area)
        }
        
        func acresWith(type: Acre, in area: LumberCollection) -> Int {
            let flattenedArea = area.flatMap { $0 }
            let filtered = flattenedArea.filter { $0 == type }
            return filtered.count
        }
        
        private func getSurrounding(y: Int, x: Int) -> [Acre] {
            var result: [Acre?] = []
            result.append(area[safe: y-1]?[safe: x-1])
            result.append(area[safe: y-1]?[safe: x])
            result.append(area[safe: y-1]?[safe: x+1])
            result.append(area[safe: y]?[safe: x-1])
            result.append(area[safe: y]?[safe: x+1])
            result.append(area[safe: y+1]?[safe: x-1])
            result.append(area[safe: y+1]?[safe: x])
            result.append(area[safe: y+1]?[safe: x+1])
            
            return result.compactMap { $0 }
        }
        
        private func modifyOpen(with surrounding: [Acre]) -> Acre {
            let surroundingTrees = surrounding.filter { $0 == .trees }
            if surroundingTrees.count >= 3 {
                return .trees
            } else {
                return .open
            }
        }
        
        private func modifyTrees(with surrounding: [Acre]) -> Acre {
            let surroundingLumberyards = surrounding.filter { $0 == .lumberyard }
            if surroundingLumberyards.count >= 3 {
                return .lumberyard
            } else {
                return .trees
            }
        }
        
        private func modifyLumberyard(with surrounding: [Acre]) -> Acre {
            let touchesLumberyard = surrounding.contains(where: { $0 == .lumberyard })
            let touchesTrees = surrounding.contains(where: { $0 == .trees })
            if touchesLumberyard && touchesTrees {
                return .lumberyard
            } else {
                return .open
            }
        }
        
        func dbgPrint() {
            print("")
            for line in area {
                for acre in line {
                    print(acre.dbgChar, terminator: "")
                }
                print("")
            }
        }
    }
}
