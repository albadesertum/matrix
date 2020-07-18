//
//  DestroyableDelegate.swift
//  DestroyableDelegate
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol DestroyableDelegate: class {
    func nodeDidDestroy(_ node: SKNode)
}
