//
//  Storable.swift
//  Storable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Storable: Datable {
    var key: String { get }
    
    func save()
    
    func load()
    
    func saveData(_ data: Data?)
    
    func loadData() -> Data?
}

public extension Storable {
    func save() {
        saveData(data)
    }
    
    func load() {
        data = loadData()
    }
    
    func saveData(_ data: Data?) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    func loadData() -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
}
