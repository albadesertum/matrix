//
//  Variable.swift
//  Variable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public typealias Numerable = Numeric & Comparable

public class Variable<T: Numerable> {
    public var maximum: T
    public var minimum: T
    
    public var variable: T {
        didSet {
            if variable < minimum {
                variable = minimum
            }
            if variable > maximum {
                variable = maximum
            }
        }
    }
    
    public var isMinimum: Bool {
        return variable == minimum
    }
    
    public var isMaximum: Bool {
        return variable == maximum
    }
    
    public init(minimum: T, maximum: T, variable: T) {
        self.minimum = minimum
        self.maximum = maximum
        self.variable = variable
    }
    
    func increase(by value: T) {
        variable = variable + value
    }
    
    func decrease(by value: T) {
        variable = variable - value
    }
}
