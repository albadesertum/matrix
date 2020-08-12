//
//  Dice.swift
//  Dice
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Dice {
    
    static public func roll(to percent: Double, attempts: Int = 10) -> Bool {
        guard attempts > 0 else {
            fatalError()
        }
        var count = 0
        for _ in 0..<attempts {
            if Double.random(in: 0.0...1.0) <= percent {
                count = count + 1
            }
        }
        return Double(count) / Double(attempts) > 0.5
    }
    
    static public func roll(to percent: Float, attempts: Int = 10) -> Bool {
        return roll(to: Double(percent), attempts: attempts)
    }
}
