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
    
    public var health = Variable<Int>(identifier: "h", minimum: 0, maximum: 0, variable: 99)
    
    public var defence = Variable<Float>(identifier: "d", minimum: 0.0, maximum: 1.0, variable: 0.0)
    
    public var medicine = Variable<Float>(identifier: "m", minimum: 0.0, maximum: 1.0, variable: 0.0)
    
    public init(m: Int, n: Int, items: [Item]) {
        self.items = Matrix<Item>(m: m, n: n, array: items)
        super.init()
        //        self.health.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension Chest: VariableDelegate {
//    public func variableBecomeMinimum(_ identifier: String) {
//        print(health)
//    }
//    
//    public func variableBecomeMaximum(_ identifier: String) {
//        print(health)
//    }
//}


public class Hero: Destroyable {
    public var health = Variable<Int>(identifier: "healt", minimum: 0, maximum: 200, variable: 200)
    
    public var defence = Variable<Float>(identifier: "defence", minimum: 0.0, maximum: 1.0, variable: 0.0)
    
    public var medicine = Variable<Float>.init(identifier: "medecine", minimum: 0.0, maximum: 1.0, variable: 1.0)
}

public class Enemy: Destroyable {
    public var health = Variable<Int>(identifier: "healt", minimum: 0, maximum: 400, variable: 400)
    
    public var defence = Variable<Float>(identifier: "defence", minimum: 0.0, maximum: 1.0, variable: 0.0)
    
    public var medicine = Variable<Float>.init(identifier: "medecine", minimum: 0.0, maximum: 1.0, variable: 1.0)
}

public class Battle {
    public var hero = Hero()
    public var enemy = Enemy()
    
    public init() {
        let actions: [Action] = [
            Attack(owner: hero, targets: [enemy]),
            Attack(owner: hero, targets: [enemy]),
            Defence(owner: enemy),
            Attack(owner: hero, targets: [enemy]),
            Clear(owner: enemy),
            Attack(owner: hero, targets: [enemy]),
            Attack(owner: hero, targets: [enemy])
        ]
        for action in actions {
            action.doAction()
            print("hero \(hero.health)")
            print("enemy \(enemy.health)")
            print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
        }
    }
}

public class Action {
    public let owner: Any
    
    public let targets: [Any]
    
    // MARK: - Init
        
    public init(owner: Any, targets: [Any] = []) {
        self.owner = owner
        self.targets = targets
    }
    
    public func doAction() {
        /* Abstract. */
    }
}

public class Defence: Action {
    override public func doAction() {
        (owner as? Destroyable)?.defence.variable = 0.5
    }
}

public class Attack: Action {
    override public func doAction() {
        let damage = 20
        for target in targets {
            (target as? Destroyable)?.makeDamage(damage)
        }
    }
}

public class Clear: Action {
    override public func doAction() {
        (owner as? Destroyable)?.defence.variable = 0.0
    }
}

//extension Action: Equatable {
//    public static func == (lhs: Action, rhs: Action) -> Bool {
//        return lhs.identifier == rhs.identifier
//    }
//}
//
//extension Action: Hashable {
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(identifier)
//    }
//}
//
//public class Target {
//
//}
