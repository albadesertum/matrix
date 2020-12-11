//
//  Variable.swift
//  Variable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public typealias Numbers = SignedNumeric & Comparable

public protocol VariableDelegate: class {
    
    func variableDidChange<T: Numbers>(_ variable: Variable<T>)
}

public class Variable<T: Numbers>: Observable {
    
    public var observers = [ObjectIdentifier : WeakReference]()
    
    public var maximum: T
    public var minimum: T
    
    public private(set) var value: T {
        didSet {
            notify { ($0 as? VariableDelegate)?.variableDidChange(self) }
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
    
    public func setValue(_ value: T) {
        if value < minimum {
            self.value = minimum
        }
        if value > maximum {
            self.value = maximum
        }
    }
    
    public func increase(by value: T) {
        setValue(self.value + value)
    }
    
    public func decrease(by value: T) {
        setValue(self.value - value)
    }
}
