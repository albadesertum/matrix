//
//  Index.swift
//  Index
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public struct Index {
    public static var zero: Index {
        return Index(i: 0, j: 0)
    }
    
    public var i: Int
    public var j: Int
    
    public var haveZero: Bool {
        return i == 0 || j == 0
    }
    
    public var tuple: (i: Int, j: Int) {
        return (i, j)
    }
    
    public var lenght: Float {
        return sqrt(Float(i * i + j * j))
    }
    
    public init(i: Int, j: Int) {
        self.i = i
        self.j = j
    }
    
    public init(tuple: (i: Int, j: Int)) {
        self.init(i: tuple.i, j: tuple.j)
    }
}
