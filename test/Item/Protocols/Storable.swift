//
//  Storable.swift
//  Storable
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Storable: class {
    var id: String { get }
    
    func save(_ data: Data?)
    func load() -> Data?
}
