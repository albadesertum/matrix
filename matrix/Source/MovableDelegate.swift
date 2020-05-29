//
//  MovableDelegate.swift
//  MovableDelegate
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol MovableDelegate: class {
    func nodeDidFinishMove(_ node: SKNode)
}
