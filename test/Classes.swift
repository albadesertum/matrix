//
//  Classes.swift
//  matrix
//
//  Created by Vladimir Psyukalov on 19.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import matrix
import SpriteKit

public typealias Charater = Attacking & Destroyable & Effectable & Equipmentable & Luckiness & Magical & Thinking & Artificial

public class Someone: Charater {
    
    public var power = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var accuracy = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var endurance = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var effects = [Effect]()
    
    public var weapon = Equipment()
    
    public var armor = Equipment()
    
    public var artefact = Equipment()
    
    public var luck = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var mana = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var points = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var defence = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var restore = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var intelegence = Variable<Int>(value: 0, minimum: 0, maximum: 2048)
    
    public var aggression = Variable<Float>(value: 0.5, minimum: 0.0, maximum: 1.0)
}

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

public protocol Artificial {
    
    var aggression: Variable<Float> { get }
}

public class ArtificialIntelligence {
    
    // MARK: - Public
    
    public func makeDesicion(by sender: Charater, and receivers: [Charater]) {
        if receivers.isEmpty {
            fatalError()
        }
        let receivers = getReceivers(for: sender, from: receivers)
        if receivers.isEmpty {
            
        } else {
            
        }
    }
    
    // MARK: - Private
    
    private func getReceivers(for sender: Charater, from receivers: [Charater]) -> [Charater] {
        let receiver = getReceiver(for: sender, from: receivers)
        let isAggression = Dice.roll(to: sender.aggression.ratio)
        let isSenderNormal = sender.points.ratio >= 0.4
        let isReceiverNormal = receiver.points.ratio >= 0.4
        let isConcentration = sender.effects.filter { $0 is Concentration }.isNotEmpty
        let percent = isConcentration ? (isReceiverNormal ? 0.6 : 0.9) : (isReceiverNormal ? 0.2 : 0.5)
        let isAttack = isSenderNormal ? isAggression : Dice.roll(to: percent)
        if isAttack {
            return isConcentration ? receivers : [receiver]
        }
        return []
    }
    
    private func getReceiver(for sender: Charater, from receivers: [Charater]) -> Charater {
        if Dice.roll(to: sender.intelegence.ratio) {
            return receivers.min { $0.points.value < $1.points.value }!
        }
        return receivers.randomElement()!
    }
}

class Cure: Action {
    override func doAction() {
        super.doAction()
        for receiver in receivers {
            (receiver as? Destroyable)?.points.increase(by: Int.random(in: 10...20))
        }
    }
}

public class Concentration: Effect {
    override public var time: Time {
        return .during(count: 1)
    }
    
    override public var isApplied: Bool {
        let level = 10.0
        return Dice.roll(to: 0.5 + 0.04 * level)
    }
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


//public class Hero: Thinking, Effectable {
//    public var hitPoints = Variable<Int>(value: 200, minimum: 0, maximum: 200)
//
//    public var defence = Variable<Float>(value: 0.0, minimum: 0.0, maximum: 1.0)
//
//    public var medicine = Variable<Float>(value: 1.0, minimum: 0.0, maximum: 1.0)
//
//    public var effects = [Effect]()
//}

//public class Enemy: Thinking, Effectable  {
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
