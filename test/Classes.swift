//
//  Classes.swift
//  matrix
//
//  Created by Vladimir Psyukalov on 19.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import matrix
import SpriteKit

public class Human: Animatable {
    public var power = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var accuracy = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var endurance = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var effects = [Effect]()
    
    public var weapon = Equipment()
    
    public var armor = Equipment()
    
    public var aartefact = Equipment()
    
    public var luck = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var intelegence = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var medicine = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var hitPoints = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var defence = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
}

//public class Chest: SKNode, Destroyable {
//    public var isCanGive: Bool {
//        return true
//    }
//
//    public var isCanTake: Bool {
//        return true
//    }
//
//    public var items: Matrix<Item>
//
//    public var hitPoints = Variable<Int>(value: 100, minimum: 0, maximum: 100)
//
//    public var defence = Variable<Float>(value: 0.0, minimum: 0.0, maximum: 1.0)
//
//    public var medicine = Variable<Float>(value: 0.0 ,minimum: 0.0, maximum: 1.0)
//
//    public init(m: Int, n: Int, items: [Item]) {
//        self.items = Matrix<Item>(m: m, n: n, array: items)
//        super.init()
//        //        self.health.delegate = self
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

//extension Chest: VariableDelegate {
//    public func variableBecomeMinimum(_ identifier: String) {
//        print(health)
//    }
//    
//    public func variableBecomeMaximum(_ identifier: String) {
//        print(health)
//    }
//}


//public class Hero: Living, Effectable {
//    public var hitPoints = Variable<Int>(value: 200, minimum: 0, maximum: 200)
//
//    public var defence = Variable<Float>(value: 0.0, minimum: 0.0, maximum: 1.0)
//
//    public var medicine = Variable<Float>(value: 1.0, minimum: 0.0, maximum: 1.0)
//
//    public var effects = [Effect]()
//}

//public class Enemy: Living, Effectable  {
//    public var hitPoints = Variable<Int>(value: 400, minimum: 0, maximum: 400)
//    
//    public var defence = Variable<Float>(value: 0.0, minimum: 0.0, maximum: 1.0)
//    
//    public var medicine = Variable<Float>(value: 1.0, minimum: 0.0, maximum: 1.0)
//    
//    public var effects = [Effect]()
//    
//    func test() {
//        let d = defence - medicine
//        switch d {
//        case .better(let difference):
//            break
//        case .worse(let difference):
//            break
//        case .equally:
//            break
//        }
//    }
//}

//public class Battle2 {
//    public var hero = Hero()
//    public var enemy = Enemy()
//
//    public init() {
//
//    }
//
//    public func test() {
//        let actions: [Action] = [
//            Apply<Poison>(owner: hero, targets: [enemy])
//        ]
//        doActions(actions)
//    }
//
//    public func test2() {
//        let actions: [Action] = [
//            Undo<Poison>(owner: enemy)
//        ]
//        doActions(actions)
//    }
//
//    func doActions(_ actions: [Action]) {
//        for action in actions {
//            action.doAction()
//            print("hero act \(hero.health)")
//            print("enemy act \(enemy.health)")
//            print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
//        }
//    }
//
//    public func apply() {
//        for unit in [hero, enemy] as [Any] {
//            if let effectable = unit as? Effectable {
//                for e in effectable.effects {
//                    e.doEffect()
//                }
//                effectable.effects = effectable.effects.filter { !$0.isCompleted }
//            }
//        }
//        print("hero eff \(hero.health)")
//        print("enemy eff \(enemy.health)")
//        print("============================================")
//    }
//}

//public class Battle {
//    public var characters: [Any]
//    public var enemies: [Any]
//
//    public var units: [Any] {
//        var result = [Any]()
//        result.append(contentsOf: characters)
//        result.append(contentsOf: enemies)
//        return result
//    }
//
//    public init(characters: [Any], enemies: [Any]) {
//        self.characters = characters
//        self.enemies = enemies
//    }
//}

public class Logic {
    public static func applyEffects(to units: [AnyObject]) {
        for unit in units {
            if let unit = unit as? Effectable {
                for effect in unit.effects {
                    effect.doEffect()
                }
                unit.effects = unit.effects.filter { !$0.isCompleted }
            }
        }
    }
    
    public static func makeMove(with actions: [Action]) {
        for action in actions {
            action.doAction()
        }
    }
}

//class TestAAA {
//    public var battle: Battle
//    
//    public init(battle: Battle) {
//        self.battle = battle
//    }
//    
//    public func make2(_ actions: [Action]) {
//        applyEffects()
//        for action in actions {
//            action.doAction()
//        }
//    }
//    
//    public func applyEffects() {
//        
//    }
//}


//public class Defence: Action {
//    override public func doAction() {
//        (owner as? Destroyable)?.defence.variable = 0.5
//    }
//}
//
//public class Attack: Action {
//    override public func doAction() {
//        let damage = 20
//        for target in targets {
//            (target as? Destroyable)?.makeDamage(damage)
//        }
//    }
//}
//
//public class Poison: Action {
//    override public func doAction() {
//        for target in targets {
//            if let effectable = target as? Effectable {
//                effectable.effects.append(PoisonEffect(owner: effectable))
//            }
//        }
//    }
//}
//
//public class Clear: Action {
//    override public func doAction() {
//        (owner as? Destroyable)?.defence.variable = 0.0
//    }
//}

//public class PoisonEffect: Effect {
//    override public func doEffect() {
//        owner?.makeDamage(6)
//    }
//}

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
