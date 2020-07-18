//
//  Itemable.swift
//  Itemable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Itemable: class {
    var isCanGive: Bool { get }
    var isCanTake: Bool { get }
    
    var items: Matrix<Item> { get }
}

public extension Itemable {
    subscript(index: Index) -> Item? {
        get {
            return self[index.tuple]
        }
        set {
            self[index.tuple] = newValue
        }
    }
    
    subscript(tuple: (i: Int, j: Int)) -> Item? {
        get {
            return self[tuple.i, tuple.j]
        }
        set {
            self[tuple.i, tuple.j] = newValue
        }
    }
    
    subscript(i: Int, j: Int) -> Item? {
        get {
            if isCanGive {
                return items[i, j]
            }
            return nil
        }
        set {
            if isCanTake {
                items[i, j] = newValue
            }
        }
    }
}
