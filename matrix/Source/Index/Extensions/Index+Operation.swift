//
//  Index+Operation.swift
//  Index+Operation
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Index {
    
    static func + (lhs: Index, rhs: Index) -> Index {
        let i = lhs.i + rhs.i
        let j = lhs.j + rhs.j
        return Index(i: i, j: j)
    }
    
    static func + (lhs: Index, rhs: (i: Int, j: Int)) -> Index {
        return lhs + Index(tuple: rhs)
    }
    
    static func + (lhs: (i: Int, j: Int), rhs: Index) -> Index {
        return Index(tuple: lhs) + rhs
    }
    
    static func += (lhs: inout Index, rhs: Index) {
        lhs = lhs + rhs
    }
    
    static func += (lhs: inout Index, rhs: (i: Int, j: Int)) {
        lhs += Index(tuple: rhs)
    }
    
    static prefix func - (rhs: Index) -> Index {
        return Index(i: -rhs.i, j: -rhs.j)
    }
    
    static func - (lhs: Index, rhs: Index) -> Index {
        return lhs + (-rhs)
    }
    
    static func - (lhs: (i: Int, j: Int), rhs: Index) -> Index {
        return Index(tuple: lhs) - rhs
    }
    
    static func - (lhs: Index, rhs: (i: Int, j: Int)) -> Index {
        return lhs - Index(tuple: rhs)
    }
    
    static func -= (lhs: inout Index, rhs: Index) {
        lhs = lhs - rhs
    }
    
    static func -= (lhs: inout Index, rhs: (i: Int, j: Int)) {
        lhs -= Index(tuple: rhs)
    }
}
