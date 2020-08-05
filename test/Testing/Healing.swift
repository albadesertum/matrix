//
//  Healing.swift
//  Healing
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import matrix

public class Healing: Action {
    override public func doAction() {
        for receiver in receivers {
            if let sender = sender as? Leveling, let receiver = receiver as? Treatable {
                let base = Int(0.08 * Float(sender.healing.level) * Float(receiver.health.maximum))
                let delta = Int(0.05 * Float(base))
                let min = base - delta
                let max = base + delta
                let heal = Int.random(in: min...max)
                receiver.makeHeal(heal)
            }
        }
    }
}
