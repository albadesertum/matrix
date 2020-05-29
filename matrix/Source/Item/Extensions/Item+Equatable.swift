//
//  Item+Equatable.swift
//  Item+Equatable
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
