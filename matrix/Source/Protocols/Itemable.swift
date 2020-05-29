//
//  Itemable.swift
//  Itemable
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Itemable: class {
    var size: Int { get }
    
    var items: [Item] { get set }
    
    subscript(index: Int) -> Item? { get set }
    
    func append(_ item: Item?) throws
    
    func remove(_ item: Item?) throws
    
    func move(_ item: Item?, to itemable: Itemable) throws
}

public extension Itemable {
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
        if let item = item, items.count < size {
            items.append(item)
            return;
        }
        throw ItemableError.notEnoughSpace
    }
    
    func remove(_ item: Item?) throws {
        if let item = item, let index = items.firstIndex(of: item) {
            items.remove(at: index)
            return
        }
        throw ItemableError.notFound
    }
    
    func move(_ item: Item?, to itemable: Itemable) throws {
        try remove(item)
        try itemable.append(item)
    }
    
    // MARK: - Private
    
    private func isValid(_ index: Int) -> Bool {
        return 0 <= index && index < items.count
    }
}
