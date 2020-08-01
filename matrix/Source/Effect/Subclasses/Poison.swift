//
//  Poison.swift
//  Poison
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Poison: Effect {
    override public var time: Time {
        return .permanently
    }
    
    override public func doEffect() {
        super.doEffect()
        // FIXME: - Change damage.
        (owner as? Treatable)?.makeDamage(0)
    }
}
