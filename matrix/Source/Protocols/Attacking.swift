//
//  Attacking.swift
//  Attacking
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Attacking: class {
    var power: Variable<Int> { get }
    var accuracy: Variable<Int> { get }
    var endurance: Variable<Int> { get }
}
