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
            } catch {
                array.append(item)
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
            } catch {
                array.append(index)
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
            } catch {
                array.append(item)
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
        do {
            try remove(item)
            try itemable.append(item)
        } catch {
            throw ItemableError.notMove([item], [])
        }
    }
    
    func move(_ items: [Item], to itemable: Itemable) throws {
        var array = [Item]()
        for item in items {
            do {
                try move(item, to: itemable)
            } catch {
                array.append(item)
            }
        }
        if array.isNotEmpty {
            throw ItemableError.notMove(array, [])
        }
    }
    
    func move(_ items: Item..., to itemable: Itemable) throws {
        try move(items, to: itemable)
    }
    
    func move(at index: Int, to itemable: Itemable) throws {
        let item = self[index]
        do {
            try remove(at: index)
            try itemable.append(item!)
        } catch {
            throw ItemableError.notMove([], [index])
        }
    }
    
    func move(at indices: [Int], to itemable: Itemable) throws {
        var array = [Int]()
        for index in indices {
            do {
                try move(at: index, to: itemable)
            } catch {
                array.append(index)
            }
        }
        if array.isNotEmpty {
            throw ItemableError.notMove([], array)
        }
    }
    
    func move(at indices: Int..., to itemable: Itemable) throws {
        try move(at: indices, to: itemable)
    }
}
