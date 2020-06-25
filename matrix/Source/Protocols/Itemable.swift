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
            if isValid(index) {
                return items[index]
            }
            return nil
        }
        set {
            if let item = newValue, isValid(index) {
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
        let count = emptySpaceCount
        if count < items.count {
            let added = Array(items[0..<count])
            let rejected = Array(items[count..<items.count])
            self.items.append(contentsOf: added)
            throw ItemableError.notEnoughSpace(rejected)
        }
        self.items.append(contentsOf: items)
    }
    
    func append(_ items: Item...) throws {
        try append(items)
    }
    
    func remove(_ item: Item?) throws {
        guard let item = item else {
            return
        }
        guard let index = items.firstIndex(of: item) else {
            throw ItemableError.notFound([item])
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
            } catch ItemableError.notFound {
                array.append(item)
            }
        }
        if !array.isEmpty {
            throw ItemableError.notFound(array)
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
    
    // MARK: - Private
    
    private func isValid(_ index: Int) -> Bool {
        return 0 <= index && index < items.count
    }
}
