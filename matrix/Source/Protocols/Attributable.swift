//
//  Attributable.swift
//  TaAttributablelent
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Attributable: class {
    
    var strength: Variable<Int> { get }
    
    var endurance: Variable<Int> { get }
    
    var intelegence: Variable<Int> { get }
    
    var agility: Variable<Int> { get }
    
    var wizdom: Variable<Int> { get }
    
    var luck: Variable<Int> { get }
}
