//
//  Datable.swift
//  Datable
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Datable: class {
    var data: Data? { get }
}
