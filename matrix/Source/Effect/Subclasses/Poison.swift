//
//  Poison.swift
//  Poison
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Poison: Effect {    
    override public func doEffect() {
        super.doEffect()
        guard let sender = sender as? Leveling, let receiver = receiver as? Leveling & Treatable else {
            return
        }
        let value = 10
        let difference = sender.poison.level - receiver.poison.level
        // FIXME:
        let base = difference * value
        let delta = Int(0.2 * Float(base))
        let min = base - delta
        let max = base + delta
        let damage = Int.random(in: min...max)
        receiver.makeDamage(damage)
    }
}
