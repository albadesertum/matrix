//
//  Storable.swift
//  Storable
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Storable: class {
    var key: String { get }
    
    func save(_ data: Data?)
    func load() -> Data?
}

public extension Storable {
    func save(_ data: Data?) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    func load() -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
}
