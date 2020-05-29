//
//  Classes.swift
//  matrix
//
//  Created by Vladimir Psyukalov on 19.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public class Chest: Itemable {
    public var size: Int
    
    public var items: [Item]
    
    public init(size: Int, items: [Item]) {
        self.size = size
        self.items = items
    }
}
