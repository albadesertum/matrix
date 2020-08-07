//
//  Destroyable.swift
//  Destroyable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol Destroyable: class {
    var hitPoints: Variable<Int> { get }
    
    var defence: Variable<Float> { get }
    
    func makeHit(_ hit: Int)
}

public extension Destroyable {
    func makeHit(_ hit: Int) {
        hitPoints.decrease(by: Int((1.0 - defence.value) * Float(hit)))
    }
}
