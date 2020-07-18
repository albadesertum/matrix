//
//  Destroyable.swift
//  Destroyable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol Destroyable: SKNode {
    var health: Variable { get }
    
    var destroyableDelegate: DestroyableDelegate? { get }
    
    func applyDamage(_ damage: Int)
    
    func applyRecovery(_ recovery: Int)
}

public extension Destroyable {
    func applyDamage(_ damage: Int) {
        health.decrease(by: damage)
        if health.isMinimum {
            destroyableDelegate?.nodeDidDestroy(self)
        }
    }
    
    func applyRecovery(_ recovery: Int) {
        health.increase(by: recovery)
    }
}
