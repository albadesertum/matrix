//
//  Itemable+Default.swift
//  Itemable+Default
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Itemable {
    func append(_ item: Item) throws {
        if items.count == size {
            throw ItemableError.notEnoughSpace
        }
        items.append(item)
        save()
    }
    
    func remove(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            save()
        }
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
