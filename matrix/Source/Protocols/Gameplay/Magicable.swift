//
//  Magicable.swift
//  Magicable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Magicable: class {
    
    var mana: Variable<Int> { get }
}
