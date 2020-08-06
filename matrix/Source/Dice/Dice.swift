//
//  Dice.swift
//  Dice
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Dice {
    static public func roll(to percent: Float, attempts: Int = 10) -> Bool {
        guard attempts > 0 else {
            fatalError()
        }
        var count = 0
        for _ in 0..<attempts {
            if Float.random(in: 0.0...1.0) <= percent {
                count = count + 1
            }
        }
        return Float(count) / Float(attempts) > 0.5
    }
}
