//
//  Itemable.swift
//  test
//
//  Created by Vladimir Psyukalov on 02.05.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Itemable: class {
    var id: String { get set }
    
    var items: [Item] { get set }
    
    func append(_ item: Item)
    func remove(_ item: Item)
}
