//
//  BooleanOperable.swift
//  BooleanOperable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol BooleanOperable {
    associatedtype T
    
    func applyOperation(_ operation: BooleanOperation, with sequence: T) -> T
}
