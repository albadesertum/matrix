//
//  SaveLoad.swift
//  SaveLoad
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class SaveLoad: Storable {
    public var data: Data? {
        get {
            return try? PropertyListSerialization.data(fromPropertyList: list as Any, format: .binary, options: .zero)
        }
        set {
            if let data = newValue {
                list = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String : Any]
            }
        }
    }
    
    public var key: String
    
    public var list: [String : Any]?
    
    public init(key: String) {
        self.key = key
    }
}
