//
//  Storable+Default.swift
//  Storable+Default
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Storable {
    func save(_ data: Data?) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: id)
        userDefaults.synchronize()
    }
    
    func load() -> Data? {
        return UserDefaults.standard.data(forKey: id)
    }
    
    func save() {
        /* Abstract. */
    }
    
    func load() {
        /* Abstract. */
    }
}
