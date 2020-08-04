//
//  FullHealing.swift
//  FullHealing
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class FullHealing: Action {
    override public func doAction() {
        for receiver in receivers {
            if let sender = sender as? Leveling, let receiver = receiver as? Treatable {
                let percent = 0.5 + 0.01 * Float(sender.healing.level)
                if Dice.roll(to: percent) {
                    receiver.makeHeal(receiver.health.maximum)
                }
            }
        }
    }
}
