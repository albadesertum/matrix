//
//  BoolOperable.swift
//  BoolOperable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol BoolOperable {
    associatedtype T
    
    func applyOperation(_ operation: BoolOperation, with sequence: T) -> T
}
