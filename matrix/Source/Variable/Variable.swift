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
    
    public var maximum: Int
    public var minimum: Int
    
    public private(set) var variable: Int {
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
    
    public init(identifier: String, minimum: Int, maximum: Int, variable: Int) {
        self.identifier = identifier
        self.minimum = minimum
        self.maximum = maximum
        self.variable = variable
    }
    
    func increase(by value: Int) {
        variable = variable + value
    }
    
    func decrease(by value: Int) {
        variable = variable - value
    }
}
