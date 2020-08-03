//
//  Leveling.swift
//  Leveling
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Leveling {
    var level: Int { get }
    
    var poison: Talent { get }
}

public extension Leveling {
    var level: Int {
        let talents = self.talents
        var sum = 0
        for talent in talents {
            sum = sum + talent.level
        }
        return Int(Float(sum) / Float(talents.count))
    }
    
    // MARK: - Private
    
    private var talents: [Talent] {
        return [poison]
    }
}
