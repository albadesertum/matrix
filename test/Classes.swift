//
//  Classes.swift
//  matrix
//
//  Created by Vladimir Psyukalov on 19.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import matrix
import SpriteKit

public typealias Animatable = Attributable & Destroyable & Effectable & Equipmentable

public class Human: Animatable, VariableDelegate {
    
    public var strength: Variable<Int>
    
    public var endurance: Variable<Int>
    
    public var intelegence: Variable<Int>
    
    public var agility: Variable<Int>
    
    public var wizdom: Variable<Int>
    
    public var luck: Variable<Int>
    
    public var health: Variable<Int>
    
    public var effects: [Effect]
    
    public var weapon: Equipment
    
    public var armor: Equipment
    
    public var artefact: Equipment
    
    init() {
        self.strength = Variable<Int>(value: 0, minimum: 0, maximum: 0)
        self.endurance = Variable<Int>(value: 0, minimum: 0, maximum: 0)
        self.intelegence = Variable<Int>(value: 0, minimum: 0, maximum: 0)
        self.agility = Variable<Int>(value: 0, minimum: 0, maximum: 0)
        self.wizdom = Variable<Int>(value: 0, minimum: 0, maximum: 0)
        self.luck = Variable<Int>(value: 0, minimum: 0, maximum: 10)
        self.health = Variable<Int>(value: 100, minimum: 0, maximum: 200)
        self.effects = []
        self.weapon = Equipment()
        self.armor = Equipment()
        self.artefact = Equipment()
        self.health.addObserver(self)
        self.luck.addObserver(self)
    }
    
    public func variableDidChange<Int>(_ variable: Variable<Int>) {
        print("!")
        if variable === health {
            print("HP \(variable.value)")
        }
        if variable === luck {
            print("LUCK \(variable.value)")
        }
    }
}

public class Warrior: Human {
    
}

public class Sorceror: Human, Magicable {
    
    public var mana: Variable<Int>
    
    override init() {
        self.mana = Variable<Int>(value: 0, minimum: 0, maximum: 0)
        super.init()
    }
    
    func test() {
        print("test!")
        health.increase(by: 20)
        luck.increase(by: 2)
        health.decrease(by: 100)
        luck.increase(by: 5)
    }
}

public class Logic {
    
    public static func effect(to units: [AnyObject]) {
        for unit in units {
            if let unit = unit as? Effectable {
                for effect in unit.effects {
                    effect.doEffect()
                }
                unit.effects = unit.effects.filter { !$0.isCompleted }
            }
        }
    }
    
    public static func move(with actions: [Action]) {
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
    
    public func makeDesicion(by sender: Animatable, and receivers: [Animatable]) {
        if receivers.isEmpty {
            fatalError()
        }
        let receivers = getReceivers(for: sender, from: receivers)
        if receivers.isEmpty {
            
        } else {
            
        }
    }
    
    // MARK: - Private
    
    private func getReceivers(for sender: Animatable, from receivers: [Animatable]) -> [Animatable] {
        //        let receiver = getReceiver(for: sender, from: receivers)
        //        let isAggression = Dice.roll(to: sender.aggression.ratio)
        //        let isSenderNormal = sender.health.ratio >= 0.4
        //        let isReceiverNormal = receiver.health.ratio >= 0.4
        //        let isConcentration = sender.effects.filter { $0 is Concentration }.isNotEmpty
        //        let percent = isConcentration ? (isReceiverNormal ? 0.6 : 0.9) : (isReceiverNormal ? 0.2 : 0.5)
        //        let isAttack = isSenderNormal ? isAggression : Dice.roll(to: percent)
        //        if isAttack {
        //            return isConcentration ? receivers : [receiver]
        //        }
        return []
    }
    
    private func getReceiver(for sender: Animatable, from receivers: [Animatable]) -> Animatable {
        //        if Dice.roll(to: sender.intelegence.ratio) {
        //            return receivers.min { $0.hea.value < $1.points.value }!
        //        }
        return receivers.randomElement()!
    }
}

//class Cure: Action {
//    override func doAction() {
//        super.doAction()
//        for receiver in receivers {
//            (receiver as? Destroyable)?.health.increase(by: Int.random(in: 10...20))
//        }
//    }
//}

/*
 
 class Cure2: Action {
 override func doAction() {
 super.doAction()
 if Dice.roll(to: 0.9) {
 for receiver in receivers {
 (receiver as? Destroyable)?.points.increase(by: Int.random(in: 60...80))
 }
 }
 }
 }
 
 class Cure3: Action {
 override func doAction() {
 super.doAction()
 if Dice.roll(to: 0.8) {
 for receiver in receivers {
 if let receiver = receiver as? Destroyable {
 receiver.points.increase(by: receiver.points.maximum)
 }
 }
 }
 }
 }
 
 */

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
