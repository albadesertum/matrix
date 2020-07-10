//
//  Itemable.swift
//  Itemable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Itemable: class {
    var size: Int { get }
    
    var items: [Item] { get set }
    
    subscript(index: Int) -> Item? { get set }
    
    func append(_ item: Item) throws
    
    func append(_ items: [Item]) throws
    
    func append(_ items: Item...) throws
    
    func remove(at index: Int) throws
    
    func remove(at indices: [Int]) throws
    
    func remove(at indices: Int...) throws
    
    func remove(_ item: Item) throws
    
    func remove(_ items: [Item]) throws
    
    func remove(_ items: Item...) throws
    
    func move(_ item: Item, to itemable: Itemable) throws
    
    func move(_ items: [Item], to itemable: Itemable) throws
    
    func move(_ items: Item..., to itemable: Itemable) throws
    
    func move(at index: Int, to itemable: Itemable) throws
    
    func move(at indices: [Int], to itemable: Itemable) throws
    
    func move(at indices: Int..., to itemable: Itemable) throws
}

public extension Itemable {
    private var isNotEnoughtSpace: Bool {
        return items.count == size
    }
    
    subscript(_ index: Int) -> Item? {
        get {
            if items.isExist(index) {
                return items[index]
            }
            return nil
        }
        set {
            if let item = newValue, items.isExist(index) {
                items[index] = item
            }
        }
    }
    
    func append(_ item: Item) throws {
        if isNotEnoughtSpace {
            throw ItemableError.notEnoughSpace([item])
        }
        items.append(item)
    }
    
    func append(_ items: [Item]) throws {
        var array = [Item]()
        for item in items {
            do {
                try append(item)
            } catch ItemableError.notEnoughSpace(let items) {
                array.append(contentsOf: items)
            }
        }
        if array.isNotEmpty {
            throw ItemableError.notEnoughSpace(array)
        }
    }
    
    func append(_ items: Item...) throws {
        try append(items)
    }
    
    func remove(at index: Int) throws {
        if items.isNotExist(index) {
            throw ItemableError.notFound([], [index])
        }
        items.remove(at: index)
    }
    
    func remove(at indices: [Int]) throws {
        var array = [Int]()
        for index in indices {
            do {
                try remove(at: index)
            } catch ItemableError.notFound(_, let indices) {
                array.append(contentsOf: indices)
            }
        }
        if array.isNotEmpty {
            throw ItemableError.notFound([], array)
        }
    }
    
    func remove(at indices: Int...) throws {
        try remove(at: indices)
    }
    
    func remove(_ item: Item) throws {
        guard let index = items.firstIndex(of: item) else {
            throw ItemableError.notFound([item], [])
        }
        items.remove(at: index)
    }
    
    func remove(_ items: [Item]) throws {
        var array = [Item]()
        for item in items {
            do {
                try remove(item)
            } catch ItemableError.notFound(let items, _) {
                array.append(contentsOf: items)
            }
        }
        if array.isNotEmpty {
            throw ItemableError.notFound(array, [])
        }
    }
    
    func remove(_ items: Item...) throws {
        try remove(items)
    }
    
    func move(_ item: Item, to itemable: Itemable) throws {
        try remove(item)
        try itemable.append(item)
    }
    
    func move(_ items: [Item], to itemable: Itemable) throws {
        var array: [Item]?
        do {
            try remove(items)
        } catch ItemableError.notFound(let items, _) {
            array = items
        }
        if let array = array {
            let setA = Set(items)
            let setB = Set(array)
            let difference = Array(setA.symmetricDifference(setB))
            try itemable.append(difference)
        } else {
            try itemable.append(items)
        }
    }
    
    func move(_ items: Item..., to itemable: Itemable) throws {
        try move(items, to: itemable)
    }
    
    func move(at index: Int, to itemable: Itemable) throws {
        let item = self[index]
        try remove(at: index)
        if let item = item {
            try itemable.append(item)
        }
    }
    
    func move(at indices: [Int], to itemable: Itemable) throws {
        var items = [Item]()
        for index in indices {
            if let item = self[index] {
                try! remove(at: index)
                items.append(item)
            }
        }
        try itemable.append(items)
    }
    
    func move(at indices: Int..., to itemable: Itemable) throws {
        try move(at: indices, to: itemable)
    }
}
