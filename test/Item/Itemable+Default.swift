//
//  Itemable+Default.swift
//  Itemable+Default
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Itemable {
    func append(_ item: Item?) throws {
        if size <= items.count {
            throw ItemableError.notEnoughSpace
        }
        if let item = item {
            items.append(item)
            save()
        }
    }
    
    func remove(_ item: Item?) {
        if let item = item, let index = items.firstIndex(of: item) {
            remove(at: index)
        }
    }
    
    func remove(at index: Int) {
        if 0 <= index && index < items.count {
            items.remove(at: index)
            save()
        }
    }
    
    func move(_ item: Item?, to itemable: Itemable) throws {
        remove(item)
        try itemable.append(item)
    }
    
    func move(at index: Int, to itemable: Itemable) throws {
        let item = items[index]
        try move(item, to: itemable)
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(items) {
            save(data)
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: id), let items = try? JSONDecoder().decode([Item].self, from: data) {
            self.items = items
        }
    }
}
