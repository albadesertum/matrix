//
//  Living.swift
//  Living
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Living: Destroyable {
    
    var health: Variable<Int> { get }
    
    var intelegence: Variable<Int> { get }
    
    var medicine: Variable<Int> { get }
}

public extension Living {
    
    var health: Variable<Int> {
        return hitPoints
    }
}
