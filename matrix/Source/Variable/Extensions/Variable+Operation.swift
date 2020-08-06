//
//  Variable+Operation.swift
//  Variable+Operation
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Variable {
    enum Difference {
        case equally, better(difference: T), worse(difference: T)
    }
    
    static func - (lhs: Variable, rhs: Variable) -> Difference {
        let difference = lhs.variable - rhs.variable
        if difference > 0 {
            return .better(difference: difference)
        }
        if difference < 0 {
            return .worse(difference: abs(difference))
        }
        return .equally
    }
}
