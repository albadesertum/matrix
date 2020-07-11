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
    
    // MARK: - Append
    
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
    
    // MARK: - Remove at
    
    func remove(at index: Int) throws {
        if items.isNotExist(index) {
            throw ItemableError.notFound([], [index])
        }
        items.remove(at: index)
    }
    
    func remove(at indices: [Int]) throws {
        var items = [Item]()
        var array = [Int]()
        for index in indices {
            if let item = self[index] {
                items.append(item)
            } else {
                array.append(index)
            }
        }
        try remove(items)
        if array.isNotEmpty {
            throw ItemableError.notFound([], array)
        }
    }
    
    func remove(at indices: Int...) throws {
        try remove(at: indices)
    }
    
    // MARK: - Remove
    
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
    
    // MARK: - Move
    
    func move(_ item: Item, to itemable: Itemable) throws {
        try remove(item)
        do {
            try itemable.append(item)
        } catch {
            try append(item)
            throw ItemableError.notEnoughSpace([item])
        }
    }
    
    func move(_ items: [Item], to itemable: Itemable) throws {
        do {
            try remove(items)
            try itemable.append(items)
        } catch ItemableError.notFound(let array, _) {
            if items.count == array.count {
                throw ItemableError.notFound(array, [])
            }
            let result = items.difference(with: array)
            do {
                try itemable.append(result)
            } catch ItemableError.notEnoughSpace(let array) {
                try append(array)
            }
        } catch ItemableError.notEnoughSpace(let array) {
            try append(array)
        }
    }
    
    func move(_ items: Item..., to itemable: Itemable) throws {
        try move(items, to: itemable)
    }
    
    // MARK: - Mave at
    
    func move(at index: Int, to itemable: Itemable) throws {
        let item = self[index]
        try remove(at: index)
        do {
            try itemable.append(item!)
        } catch {
            try append(item!)
            throw ItemableError.notEnoughSpace([item!])
        }
    }
    
    func move(at indices: [Int], to itemable: Itemable) throws {
        do {
            try remove(at: indices)
        } catch ItemableError.notFound(_, let array) {
            if indices.count == array.count {
                throw ItemableError.notFound([], array)
            }
            let difference = indices.difference(with: array)
            var result = [Item]()
            for index in difference {
                result.append(items[index])
            }
            do {
                try itemable.append(result)
            } catch ItemableError.notEnoughSpace(let array) {
                try append(array)
                throw ItemableError.notEnoughSpace(array)
            }
        }
    }
    
    func move(at indices: Int..., to itemable: Itemable) throws {
        try move(at: indices, to: itemable)
    }
}
