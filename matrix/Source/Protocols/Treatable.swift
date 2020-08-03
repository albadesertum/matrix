//
//  Treatable.swift
//  Treatable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Treatable: Destroyable {
    func makeHeal(_ heal: Int)
}

public extension Treatable {
    func makeHeal(_ heal: Int) {
        health.increase(by: heal)
    }
}
