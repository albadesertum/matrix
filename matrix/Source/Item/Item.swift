//
//  Item.swift
//  Item
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Item: Codable {
    private enum Keys: String, CodingKey {
        case id
    }
    
    public var id: String
    
    public init(id: String) {
        self.id = id
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
    }
}
