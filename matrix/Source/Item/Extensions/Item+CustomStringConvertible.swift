//
//  Item+CustomStringConvertible.swift
//  Item+CustomStringConvertible
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

extension Item: CustomStringConvertible {
    public var description: String {
        return id
    }
}
