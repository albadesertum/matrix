//
//  Medicable.swift
//  Medicable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Medicable: Destroyable {
    var health: Variable<Int> { get }
    
    var medicine: Variable<Float> { get }
    
    func makeHeal(_ heal: Int)
}

public extension Medicable {
    var health: Variable<Int> {
        return hitPoints
    }
    
    func makeHeal(_ heal: Int) {
        health.increase(by: Int(medicine.value * Float(heal)))
    }
}
