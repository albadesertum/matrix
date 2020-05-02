//
//  Itemable.swift
//  Itemable
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Itemable: Storable {
    var size: Int { get }
    
    var items: [Item] { get set }
    
    func append(_ item: Item) throws
    func remove(_ item: Item)
}
