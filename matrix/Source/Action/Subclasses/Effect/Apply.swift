//
//  Apply.swift
//  Apply
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

open class Apply<T: Effect>: Action {
    
    override open func doAction() {
        for receiver in receivers {
            if let receiver = receiver as? Effectable {
                let effect = T(sender: sender, receiver: receiver)
                if effect.isApplied {
                    receiver.effects.append(effect)
                }
            }
        }
    }
}
