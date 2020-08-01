//
//  Variable.swift
//  Variable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public typealias Numberable = Numeric & Comparable

public class Variable<T: Numberable> {
    public let identifier: String
    
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
    
    public init(identifier: String, minimum: T, maximum: T, variable: T) {
        self.identifier = identifier
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
