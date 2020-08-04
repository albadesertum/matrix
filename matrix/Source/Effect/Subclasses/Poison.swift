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
        let compare = sender.poison.compare(with: receiver.poison)
        var ratio: Int
        switch compare {
        case .equally:
            ratio = 1
        case .better(let difference):
            ratio = difference >= 6 ? Int(2.0 * Float(difference)) : difference
        case .worse(let difference):
            ratio = difference >= 4 ? 0 : 1
        }
        let base = ratio * 10
        let delta = Int(0.1 * Float(base))
        let min = base - delta
        let max = base + delta
        let damage = Int.random(in: min...max)
        receiver.makeDamage(damage)
    }
}
