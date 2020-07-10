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
    
    var isEnoughtSpace: Bool { get }
    
    var emptySpaceCount: Int { get }
    
    subscript(index: Int) -> Item? { get set }
    
    func append(_ item: Item?) throws
    
    func append(_ items: [Item]?) throws
    
    func append(_ items: Item...) throws
    
    func remove(at index: Int?) throws
    
    func remove(at indices: [Int]?) throws
    
    func remove(at indices: Int...) throws
    
    func remove(_ item: Item?) throws
    
    func remove(_ items: [Item]?) throws
    
    func remove(_ items: Item...) throws
    
    func move(_ item: Item?, to itemable: Itemable) throws
    
    func move(_ items: [Item]?, to itemable: Itemable) throws
    
    func move(_ items: Item..., to itemable: Itemable) throws
}

public extension Itemable {
    var isEnoughtSpace: Bool {
        return items.count < size
    }
    
    var emptySpaceCount: Int {
        return isEnoughtSpace ? size - items.count : 0
    }
    
    subscript(_ index: Int) -> Item? {
        get {
            if items.check(index) {
                return items[index]
            }
            return nil
        }
        set {
            if let item = newValue, items.check(index) {
                items[index] = item
            }
        }
    }
    
    func append(_ item: Item?) throws {
        guard let item = item else {
            return
        }
        if !isEnoughtSpace {
            throw ItemableError.notEnoughSpace([item])
        }
        items.append(item)
    }
    
    func append(_ items: [Item]?) throws {
        guard let items = items else {
            return
        }
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
    
    func remove(at index: Int?) throws {
        guard let index = index else {
            return
        }
        if !items.check(index) {
            throw ItemableError.notFound(nil, [index])
        }
        items.remove(at: index)
    }
    
    func remove(at indices: [Int]?) throws {
        guard let indices = indices else {
            return
        }
        var array = [Int]()
        for index in indices {
            do {
                try remove(at: index)
            } catch ItemableError.notFound(_, let indices) {
                array.append(contentsOf: indices ?? [])
            }
        }
        if array.isNotEmpty {
            throw ItemableError.notFound(nil, array)
        }
    }
    
    func remove(at indices: Int...) throws {
        try remove(at: indices)
    }
    
    func remove(_ item: Item?) throws {
        guard let item = item else {
            return
        }
        guard let index = items.firstIndex(of: item) else {
            throw ItemableError.notFound([item], nil)
        }
        items.remove(at: index)
    }
    
    func remove(_ items: [Item]?) throws {
        guard let items = items else {
            return
        }
        var array = [Item]()
        for item in items {
            do {
                try remove(item)
            } catch ItemableError.notFound(let items, _) {
                array.append(contentsOf: items ?? [])
            }
        }
        if array.isNotEmpty {
            throw ItemableError.notFound(array, nil)
        }
    }
    
    func remove(_ items: Item...) throws {
        try remove(items)
    }
    
    func move(_ item: Item?, to itemable: Itemable) throws {
        try remove(item)
        try itemable.append(item)
    }
    
    func move(_ items: [Item]?, to itemable: Itemable) throws {
        try remove(items)
        try itemable.append(items)
    }
    
    func move(_ items: Item..., to itemable: Itemable) throws {
        try move(items, to: itemable)
    }
}
