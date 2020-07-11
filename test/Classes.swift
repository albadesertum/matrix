//
//  Classes.swift
//  matrix
//
//  Created by Vladimir Psyukalov on 19.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import matrix

public class Chest: Itemable {
    public var items: Matrix<Item>
    
    public init(m: Int, n: Int, items: [Item]) {
        self.items = Matrix<Item>(m: m, n: n, array: items)
    }
}
