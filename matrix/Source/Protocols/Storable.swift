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
}

public extension Storable {
    
    func save() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    func load() {
        data = UserDefaults.standard.data(forKey: key)
    }
}
