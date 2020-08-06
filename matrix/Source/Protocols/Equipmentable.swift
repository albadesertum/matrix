//
//  Equipmentable.swift
//  Equipmentable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Equipmentable: class {
    var weapon: Equipment { get }
    var armor: Equipment { get }
    var aartefact: Equipment { get }
}

public protocol Attacking: class {
    var power: Variable<Int> { get }
    var accuracy: Variable<Int> { get }
    var endurance: Variable<Int> { get }
}

public protocol Luckiness: Curable {
    var luck: Variable<Int> { get }
}
