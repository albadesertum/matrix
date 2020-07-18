//
//  Variable.swift
//  Variable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Variable {
    public private(set) var identifier: String
    
    public private(set) var variable: Int
    
    public var maximum: Int
    public var minimum: Int
    
    public weak var delegate: VariableDelegate?
    
    public var isMinimum: Bool {
        return variable <= minimum
    }
    
    public var isMaximum: Bool {
        return variable >= maximum
    }
    
    public init(_ identifier: String, _ variable: Int, _ minimum: Int, _ maximum: Int) {
        self.identifier = identifier
        self.variable = variable
        self.minimum = minimum
        self.maximum = maximum
    }
    
    func increase(by value: Int) {
        variable = variable + value
        if isMinimum {
            variable = minimum
            delegate?.variableBecomeMinimum(identifier)
        }
        if isMaximum {
            variable = maximum
            delegate?.variableBecomeMaximum(identifier)
        }
    }
    
    func decrease(by value: Int) {
        increase(by: -value)
    }
}
