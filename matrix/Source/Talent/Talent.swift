//
//  Talent.swift
//  Talent
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Talent {
    public private(set) var used: Int
    
    private var counter: Int
    
    public var level: Int {
        return Int(0.1 * Float(used)) + 1
    }
    
    // MARK: - Init
    
    public init(used: Int) {
        self.used = used
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
}
