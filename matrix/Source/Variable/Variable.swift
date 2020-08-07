//
//  Variable.swift
//  Variable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Variable<T: SignedNumeric & Comparable> {
    public var maximum: T
    public var minimum: T
    
    public var value: T {
        didSet {
            if value < minimum {
                value = minimum
            }
            if value > maximum {
                value = maximum
            }
        }
    }
    
    public var isMinimum: Bool {
        return value == minimum
    }
    
    public var isMaximum: Bool {
        return value == maximum
    }
    
    public init(value: T, minimum: T, maximum: T) {
        self.value = value
        self.minimum = minimum
        self.maximum = maximum
    }
    
    public func increase(by value: T) {
        self.value = self.value + value
    }
    
    public func decrease(by value: T) {
        self.value = self.value - value
    }
}
