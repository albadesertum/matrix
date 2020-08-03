//
//  Destroyable.swift
//  Destroyable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol Destroyable: class {
    var health: Variable<Int> { get }
    
    func makeDamage(_ damage: Int)
}

public extension Destroyable {
    func makeDamage(_ damage: Int) {
        health.decrease(by: damage)
    }
}
