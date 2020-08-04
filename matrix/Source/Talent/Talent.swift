//
//  Talent.swift
//  Talent
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Talent {
    public enum Compare {
        case equally, better(difference: Int), worse(difference: Int)
    }
    
    public private(set) var used: Int
    
    private var divider: Int
    
    private var counter: Int
    
    public var level: Int {
        return used / divider + 1
    }
    
    // MARK: - Init
    
    public init(used: Int, divider: Int) {
        self.used = used
        self.divider = divider
        self.counter = 0
    }
    
    // MARK: - Public
    
    public func increase() {
        counter = counter + 1
    }
    
    public func apply() {
        used = counter
        counter = 0
    }
    
    public func compare(with talent: Talent) -> Compare {
        let difference = level - talent.level
        if difference > 0 {
            return .better(difference: difference)
        }
        if difference < 0 {
            return .worse(difference: abs(difference))
        }
        return .equally
    }
}
