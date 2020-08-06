//
//  Curable.swift
//  Curable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Curable: Destroyable {
    var сurability: Variable<Float> { get }
}
