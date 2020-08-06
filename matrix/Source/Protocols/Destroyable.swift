//
//  Destroyable.swift
//  Destroyable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol Destroyable: class {
    var strength: Variable<Int> { get }
    
    var defence: Variable<Float> { get }
}
