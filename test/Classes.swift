//
//  Classes.swift
//  matrix
//
//  Created by Vladimir Psyukalov on 19.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import matrix
import SpriteKit

public class Chest: SKNode, Itemable, Destroyable {
    public var isCanGive: Bool {
        return true
    }
    
    public var isCanTake: Bool {
        return true
    }
    
    public var items: Matrix<Item>
    
    public var health = Variable("health", 60, 0, 100)
    
    public weak var destroyableDelegate: DestroyableDelegate?
    
    public init(m: Int, n: Int, items: [Item]) {
        self.items = Matrix<Item>(m: m, n: n, array: items)
        super.init()
        self.health.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Chest: VariableDelegate {
    public func variableBecomeMinimum(_ identifier: String) {
        print(health)
    }
    
    public func variableBecomeMaximum(_ identifier: String) {
        print(health)
    }
}
