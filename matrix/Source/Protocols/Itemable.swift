//
//  Itemable.swift
//  Itemable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Itemable: class {
    var items: Matrix<Item> { get }
}
